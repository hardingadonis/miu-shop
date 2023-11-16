package io.hardingadonis.miu.model;

public enum OrderStatus {
    PROCESSING("processing"),
    SHIPPING("shipping"),
    DONE("done"),
    CANCELED("canceled");

    private final String label;

    private OrderStatus(String label) {
        this.label = label;
    }

    public static OrderStatus create(String status) {
        switch (status) {
            case "processing":
                return PROCESSING;
            case "shipping":
                return SHIPPING;
            case "done":
                return DONE;
            case "canceled":
            default:
                return CANCELED;
        }
    }

    @Override
    public String toString() {
        return label;
    }
}
