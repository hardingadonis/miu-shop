package io.hardingadonis.miu.model;

public enum AdminRole {
    SUPER_ADMIN("super_admin"),
    ADMIN("admin");

    private final String label;

    private AdminRole(String label) {
        this.label = label;
    }

    public static AdminRole create(String role) {
        switch (role) {
            case "super_admin":
                return SUPER_ADMIN;
            case "admin":
            default:
                return ADMIN;
        }
    }

    @Override
    public String toString() {
        return label;
    }
}
