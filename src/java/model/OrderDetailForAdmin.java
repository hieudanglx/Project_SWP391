/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Dinh Van Do - CE182224
 */
public class OrderDetailForAdmin {
    private int OrderID;
    private String Address;
    private Date Date;
    private String Status;
    private double Total;
    private String PhoneNumber;
    private String fullNameCustomer;
    private String fullNameStaff;
    private int Quantity;
     private String productName;
    private int price;
    private String color;

    public OrderDetailForAdmin(int OrderID, String Address, Date Date, String Status, double Total, String PhoneNumber, String fullNameCustomer, String fullNameStaff, int Quantity, String productName, int price, String color) {
        this.OrderID = OrderID;
        this.Address = Address;
        this.Date = Date;
        this.Status = Status;
        this.Total = Total;
        this.PhoneNumber = PhoneNumber;
        this.fullNameCustomer = fullNameCustomer;
        this.fullNameStaff = fullNameStaff;
        this.Quantity = Quantity;
        this.productName = productName;
        this.price = price;
        this.color = color;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public double getTotal() {
        return Total;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public String getFullNameCustomer() {
        return fullNameCustomer;
    }

    public void setFullNameCustomer(String fullNameCustomer) {
        this.fullNameCustomer = fullNameCustomer;
    }

    public String getFullNameStaff() {
        return fullNameStaff;
    }

    public void setFullNameStaff(String fullNameStaff) {
        this.fullNameStaff = fullNameStaff;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
    
    
}
