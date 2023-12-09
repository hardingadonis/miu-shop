package io.hardingadonis.miu.model;

import java.time.*;

public class Category {

    private int ID;
    private String name;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private LocalDateTime deleteAt;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public Category(String name, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.name = name;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.deleteAt = deleteAt;
    }

    public Category(int ID, String name, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.ID = ID;
        this.name = name;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
        return "Category{" + "ID=" + ID + ", name=" + name + ", createAt=" + createAt + ", updateAt=" + updateAt + ", deleteAt=" + deleteAt + '}';
    }
}
