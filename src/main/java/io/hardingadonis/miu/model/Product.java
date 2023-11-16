package io.hardingadonis.miu.model;

import java.time.*;
import java.util.*;

public class Product {

    private int ID;
    private String branch;
    private String name;
    private int categoryID;
    private String origin;
    private String expiryDate;
    private String weight;
    private String preservation;
    private int price;
    private int amount;
    private String thumbnail;
    private List<String> images;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private LocalDateTime deleteAt;

    public Product() {
    }

    public Product(String branch, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, int price, int amount, String thumbnail, List<String> images) {
        this.branch = branch;
        this.name = name;
        this.categoryID = categoryID;
        this.origin = origin;
        this.expiryDate = expiryDate;
        this.weight = weight;
        this.preservation = preservation;
        this.price = price;
        this.amount = amount;
        this.thumbnail = thumbnail;
        this.images = images;
    }

    public Product(String branch, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, int price, int amount, String thumbnail, List<String> images, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.branch = branch;
        this.name = name;
        this.categoryID = categoryID;
        this.origin = origin;
        this.expiryDate = expiryDate;
        this.weight = weight;
        this.preservation = preservation;
        this.price = price;
        this.amount = amount;
        this.thumbnail = thumbnail;
        this.images = images;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.deleteAt = deleteAt;
    }

    public Product(int ID, String branch, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, int price, int amount, String thumbnail, List<String> images, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.ID = ID;
        this.branch = branch;
        this.name = name;
        this.categoryID = categoryID;
        this.origin = origin;
        this.expiryDate = expiryDate;
        this.weight = weight;
        this.preservation = preservation;
        this.price = price;
        this.amount = amount;
        this.thumbnail = thumbnail;
        this.images = images;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.deleteAt = deleteAt;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getWeight() {
        return weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public String getPreservation() {
        return preservation;
    }

    public void setPreservation(String preservation) {
        this.preservation = preservation;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
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

    public LocalDateTime getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDateTime deleteAt) {
        this.deleteAt = deleteAt;
    }

    @Override
    public String toString() {
        return "Product{" + "ID=" + ID + ", branch=" + branch + ", name=" + name + ", categoryID=" + categoryID + ", origin=" + origin + ", expiryDate=" + expiryDate + ", weight=" + weight + ", preservation=" + preservation + ", price=" + price + ", amount=" + amount + ", thumbnail=" + thumbnail + ", images=" + images + ", createAt=" + createAt + ", updateAt=" + updateAt + ", deleteAt=" + deleteAt + '}';
    }
}
