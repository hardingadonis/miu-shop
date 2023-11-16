package io.hardingadonis.miu.model.detail;

public enum Payment {
    COD("cod"),
    VNPAY("vnpay");

    private final String label;

    private Payment(String label) {
        this.label = label;
    }

    public static Payment create(String payment) {
        switch (payment) {
            case "vnpay":
                return VNPAY;
            case "cod":
            default:
                return COD;
        }
    }

    @Override
    public String toString() {
        return label;
    }
}
