package io.hardingadonis.miu.model;

import io.hardingadonis.miu.model.detail.*;
import java.time.*;

public class Order {

    private int ID;
    private int userID;
    private long totalPrice;
    private Payment payment;
    private OrderStatus status;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;

    public Order() {
    }

    public Order(int userID, long totalPrice, Payment payment, OrderStatus status) {
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.payment = payment;
        this.status = status;
    }

    public Order(int userID, long totalPrice, Payment payment, OrderStatus status, LocalDateTime createAt, LocalDateTime updateAt) {
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.payment = payment;
        this.status = status;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public Order(int ID, int userID, long totalPrice, Payment payment, OrderStatus status, LocalDateTime createAt, LocalDateTime updateAt) {
        this.ID = ID;
        this.userID = userID;
        this.totalPrice = totalPrice;
        this.payment = payment;
        this.status = status;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "Order{" + "ID=" + ID + ", userID=" + userID + ", totalPrice=" + totalPrice + ", payment=" + payment + ", status=" + status + ", createAt=" + createAt + ", updateAt=" + updateAt + '}';
    }
}
