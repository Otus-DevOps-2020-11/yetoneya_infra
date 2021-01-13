package ru.otus.elena.aws;

import com.fasterxml.jackson.databind.ObjectMapper;
import yandex.cloud.api.compute.v1.InstanceOuterClass;
import yandex.cloud.api.compute.v1.InstanceServiceGrpc;
import yandex.cloud.api.compute.v1.InstanceServiceOuterClass;
import yandex.cloud.sdk.ServiceFactory;
import yandex.cloud.sdk.ServiceFactoryConfig;
import yandex.cloud.sdk.auth.OauthToken;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class Inventory {

    private static final String TOKEN = "YOUR_TOKEN";
    private static final String FOLDER_ID = "YOUR_FOLDER_IN";
    private static final String PATH = "./";
    private static final Logger logger = Logger.getLogger("Inventory");

    public static void main(String... args) {
        if (args.length == 0) createInventoryFromYC();
        else createInventoryFromJsonFile(args[0]);
    }

    static void createInventoryFromYC() {
        Map<String, Map<String, String>> activeHosts = getActiveHosts();
        if (!activeHosts.isEmpty()) createJsonFile(activeHosts);
    }

    private static Map<String, Map<String, String>> getActiveHosts() {
        ServiceFactoryConfig config = ServiceFactoryConfig.builder().credentials(new OauthToken(TOKEN)).requestTimeout(Duration.ofMinutes(1L)).build();
        ServiceFactory factory = new ServiceFactory(config);
        InstanceServiceGrpc.InstanceServiceBlockingStub instanceService = factory.create(InstanceServiceGrpc.InstanceServiceBlockingStub.class, InstanceServiceGrpc::newBlockingStub);
        return instanceService.list(buildListInstancesRequest())
                .getInstancesList()
                .stream()
                .filter(instance -> instance.getStatus().equals(InstanceOuterClass.Instance.Status.RUNNING))
                .collect(Collectors.groupingBy(instance -> {
                            if (instance.getName().contains("app")) return "app";
                            else return "db";
                        },
                        Collectors.toMap(InstanceOuterClass.Instance::getName, instance -> instance.getNetworkInterfaces(0)
                                .getPrimaryV4Address()
                                .getOneToOneNat()
                                .getAddress())));
    }

    private static InstanceServiceOuterClass.ListInstancesRequest buildListInstancesRequest() {
        return InstanceServiceOuterClass.ListInstancesRequest.newBuilder().setFolderId(FOLDER_ID).build();
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
            mapper.writeValue(Paths.get(PATH, "inventory.json").toFile(), all);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    static void createInventoryFromJsonFile(String fileName) {
        try {
            String json =  Files.readString(Paths.get(fileName)).strip().replaceAll("\\s+","");
            if (checkJson(json)) {
                Files.writeString(Paths.get("inventory.json"), json);
            } else logger.log(Level.WARNING, "json is not valid");
        } catch (IOException ex) {
            logger.log(Level.SEVERE, ex.toString());
        }
    }

    static boolean checkJson(String json) {
        String pattern = "\\{(\"(app|db)\":\\{\"hosts\":\\[?(\\{\".+\":\\{\"ansible_host\":\"(\\d{1,3}\\.){3}\\d{1,3}\"}},?)+]?},?){1,2}}";
        return json.matches(pattern);
    }

}
