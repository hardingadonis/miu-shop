package io.hardingadonis.miu.model.detail;

public enum UserGender {
    MALE("male"),
    FEMALE("female");

    private final String label;

    private UserGender(String label) {
        this.label = label;
    }

    public static UserGender create(String gender) {
        switch (gender) {
            case "male":
                return MALE;
            case "female":
            default:
                return FEMALE;
        }
    }

    @Override
    public String toString() {
        return label;
    }
}
