package ru.otus.elena.gcp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.compute.Compute;
import com.google.api.services.compute.model.Instance;
import com.google.api.services.compute.model.InstanceList;


import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;

import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class GCInventory {

    private static final String PATH = "./";
    private static final Logger logger = Logger.getLogger("GCInventory");

    public static void main(String args[]) throws IOException, GeneralSecurityException {

        String project = "mythic-method-301917";
        String zone = "europe-north1-a";
        Compute computeService = createComputeService();
        createJsonFile(getRunningInstances(computeService.instances().list(project, zone)));
    }

    static Compute createComputeService() throws IOException, GeneralSecurityException {
        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
        JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();

        GoogleCredential credential = GoogleCredential.fromStream(Files.newInputStream(Paths.get(PATH, "gkey.json")));

        if (credential.createScopedRequired()) {
            credential =
                    credential.createScoped(Collections.singletonList("https://www.googleapis.com/auth/cloud-platform"));
        }

        return new Compute.Builder(httpTransport, jsonFactory, credential)
                .setApplicationName("Google-ComputeSample/0.1")
                .build();
    }

    static Map<String, Map<String, String>> getRunningInstances(Compute.Instances.List request) throws IOException {
        Map<String, Map<String, String>> instances = new HashMap<>();
        InstanceList response;
        do {
            response = request.execute();
            if (response.getItems() == null) {
                continue;
            }
            instances.putAll(response.getItems().stream()
                    .filter(instance -> instance.getStatus().equals("RUNNING"))
                    .collect(Collectors.groupingBy(instance -> {
                                if (instance.getName().contains("app")) return "app";
                                else return "db";
                            },
                            Collectors.toMap(Instance::getName, instance -> instance
                                    .getNetworkInterfaces()
                                    .get(0)
                                    .getAccessConfigs()
                                    .get(0)
                                    .getNatIP()))));

            request.setPageToken(response.getNextPageToken());
        } while (response.getNextPageToken() != null);
        return instances;
    }

    static void createJsonFile(Map<String, Map<String, String>> activeHosts) {
        Map<String, Map<String, Map<String, Map<String, String>>>> all = new HashMap<>();
        activeHosts.forEach((l, m) -> {
            Map<String, Map<String, String>> apps = new HashMap<>();
            m.forEach((k, v) -> apps.put(k, Map.of("ansible_host", v)));
            all.put(l, Map.of("hosts", apps));
        });
        ObjectMapper mapper = new ObjectMapper();

        try {
            mapper.writeValue(Paths.get(PATH, "inventory-gc.json").toFile(), all);
        } catch (IOException ex) {
            logger.log(Level.SEVERE, ex.toString());
        }
    }
}

