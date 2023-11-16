package io.hardingadonis.miu.model;

import java.time.*;
import java.util.*;

public class Product {

    private int ID;
    private String brand;
    private String name;
    private int categoryID;
    private String origin;
    private String expiryDate;
    private String weight;
    private String preservation;
    private long price;
    private int amount;
    private String thumbnail;
    private List<String> images;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private LocalDateTime deleteAt;

    public Product() {
    }

    public Product(String brand, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, long price, int amount, String thumbnail, List<String> images) {
        this.brand = brand;
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

    public Product(String brand, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, long price, int amount, String thumbnail, List<String> images, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.brand = brand;
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

    public Product(int ID, String brand, String name, int categoryID, String origin, String expiryDate, String weight, String preservation, long price, int amount, String thumbnail, List<String> images, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.ID = ID;
        this.brand = brand;
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
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

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
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
        return "Product{" + "ID=" + ID + ", brand=" + brand + ", name=" + name + ", categoryID=" + categoryID + ", origin=" + origin + ", expiryDate=" + expiryDate + ", weight=" + weight + ", preservation=" + preservation + ", price=" + price + ", amount=" + amount + ", thumbnail=" + thumbnail + ", images=" + images + ", createAt=" + createAt + ", updateAt=" + updateAt + ", deleteAt=" + deleteAt + '}';
    }
}
