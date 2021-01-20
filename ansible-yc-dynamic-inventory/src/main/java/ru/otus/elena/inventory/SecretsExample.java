package ru.otus.elena.inventory;

public enum SecretsExample {

  FOLDER_ID("folder_id"),
  TOKEN("token");

  private String value;

  public String getValue() {
    return value;
  }

  SecretsExample(String value) {
    this.value = value;
  }

}
