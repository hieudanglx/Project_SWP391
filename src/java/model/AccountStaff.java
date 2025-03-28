/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
public class AccountStaff {
    private int staffID;
    private String address;
    private String email;
    private String password;
    private String fullName;
    private String phoneNumber;
    private String username;
    private String cccd;
    private String sex;
    private String dob;
    private String province_city;
    private int status;
    private boolean isDelete;

    public AccountStaff() {
    }

    public AccountStaff(int staffID, String address, String email, String password, String fullName, String phoneNumber, String username, String cccd, String sex, String dob, String province_city, int status) {
        this.staffID = staffID;
        this.address = address;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.username = username;
        this.cccd = cccd;
        this.sex = sex;
        this.dob = dob;
        this.province_city = province_city;
        this.status = status;
    }
     public AccountStaff(String fullName, String username, String password, String email, 
                      String phoneNumber, String address, String cccd, 
                      String province_city, String dob, String sex, int status) {
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.cccd = cccd;
        this.province_city = province_city;
        this.dob = dob;
        this.sex = sex;
        this.status = status;
        this.isDelete = false;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

     public boolean isDelete() {
        return isDelete;
    }

    public void setDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getProvince_city() {
        return province_city;
    }

    public void setProvince_city(String province_city) {
        this.province_city = province_city;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
}