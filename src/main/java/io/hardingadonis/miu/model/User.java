/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package io.hardingadonis.miu.model;

import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class User {

    private int ID;
    private String fullName;
    private int birthYear;
    private int gender;
    private String email;
    private String hashedPassword;
    private String avatarPath;
    private List<Object> address;
    private int status;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private LocalDateTime deleteAt;

    public User() {
    }

    public User(int ID, String fullName, int birthYear, int gender, String email, String hashedPassword, String avatarPath, List<Object> address, int status, LocalDateTime createAt, LocalDateTime updateAt, LocalDateTime deleteAt) {
        this.ID = ID;
        this.fullName = fullName;
        this.birthYear = birthYear;
        this.gender = gender;
        this.email = email;
        this.hashedPassword = hashedPassword;
        this.avatarPath = avatarPath;
        this.address = address;
        this.status = status;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(int birthYear) {
        this.birthYear = birthYear;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }

    public List<Object> getAddress() {
        return address;
    }

    public void setAddress(List<Object> address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
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

    public LocalDateTime getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDateTime deleteAt) {
        this.deleteAt = deleteAt;
    }

    @Override
    public String toString() {
        return "User{" + "ID=" + ID + ", fullName=" + fullName + ", birthYear=" + birthYear + ", gender=" + gender + ", email=" + email + ", hashedPassword=" + hashedPassword + ", avatarPath=" + avatarPath + ", address=" + address + ", status=" + status + ", createAt=" + createAt + ", updateAt=" + updateAt + ", deleteAt=" + deleteAt + '}';
    }

}
