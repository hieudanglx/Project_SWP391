/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
public class AccountCustomer {

    private int customerID;
    private String username;
    private String fullName;
    private String email;
    private String password;
    private String address;
    private String phoneNumber;
    private int status;
    private String sex;
    private String dob;
    private String imgCustomer;

    public AccountCustomer() {
    }

    public AccountCustomer(int customerID, String username, String fullName, String email, String password, String address, String phoneNumber, int status, String sex, String dob, String imgCustomer) {
        this.customerID = customerID;
        this.username = username;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.sex = sex;
        this.dob = dob;
        this.imgCustomer = imgCustomer;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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

    public String getImgCustomer() {
        return imgCustomer;
    }

    public void setImgCustomer(String imgCustomer) {
        this.imgCustomer = imgCustomer;
    }

}
