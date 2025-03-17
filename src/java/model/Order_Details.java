/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class Order_Details {

    private int OrderDetaiID;
    private int Quantity;
    private int ProductID;
    private int OrderID;
    private String ProductName;
    private int Price;
    private String ImageURL;
    private Date Date;
    private String Status;
    private String CustomerName;
    private String Address;
    private String PhoneNumber;
    private double Total;

    public Order_Details() {
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID, String ProductName, int Price, String ImageURL, Date Date, String Status, String CustomerName, String Address, String PhoneNumber) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
        this.ProductName = ProductName;
        this.Price = Price;
        this.ImageURL = ImageURL;
        this.Date = Date;
        this.Status = Status;
        this.CustomerName = CustomerName;
        this.Address = Address;
        this.PhoneNumber = PhoneNumber;
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID, String ProductName, int Price, String ImageURL, Date Date, String Status, String CustomerName, String Address, String PhoneNumber, double Total) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
        this.ProductName = ProductName;
        this.Price = Price;
        this.ImageURL = ImageURL;
        this.Date = Date;
        this.Status = Status;
        this.CustomerName = CustomerName;
        this.Address = Address;
        this.PhoneNumber = PhoneNumber;
        this.Total = Total;
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID, String ProductName, int Price, String ImageURL, Date Date, String Status, String Address, String PhoneNumber) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
        this.ProductName = ProductName;
        this.Price = Price;
        this.ImageURL = ImageURL;
        this.Date = Date;
        this.Status = Status;
        this.Address = Address;
        this.PhoneNumber = PhoneNumber;
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID, String ProductName, int Price, String ImageURL, Date Date, String Status) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
        this.ProductName = ProductName;
        this.Price = Price;
        this.ImageURL = ImageURL;
        this.Date = Date;
        this.Status = Status;
    }

   
    public int getOrderDetaiID() {
        return OrderDetaiID;
    }

    public void setOrderDetaiID(int OrderDetaiID) {
        this.OrderDetaiID = OrderDetaiID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public int getPrice() {
        return Price;
    }

    public void setPrice(int Price) {
        this.Price = Price;
    }

    public String getImageURL() {
        return ImageURL;
    }

    public void setImageURL(String ImageURL) {
        this.ImageURL = ImageURL;
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

    public String getCustomerName() {
        return CustomerName;
    }

    public void setCustomerName(String CustomerName) {
        this.CustomerName = CustomerName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public double getTotal() {
        return Total;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }

}
