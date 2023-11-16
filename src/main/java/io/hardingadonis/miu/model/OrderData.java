package io.hardingadonis.miu.model;

public class OrderData {

    private int orderID;
    private int productID;
    private int amount;

    public OrderData() {
    }

    public OrderData(int orderID, int productID, int amount) {
        this.orderID = orderID;
        this.productID = productID;
        this.amount = amount;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "OrderData{" + "orderID=" + orderID + ", productID=" + productID + ", amount=" + amount + '}';
    }
}