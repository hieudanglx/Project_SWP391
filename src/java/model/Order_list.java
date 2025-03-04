/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.text.DecimalFormat;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class Order_list {

   private int OrderID;
    private int CustomerID;
    private int StaffID;
    private String Address;
    private Date Date;
    private String Status;
    private double Total;
    private String PhoneNumber;

    private int year;
    private int period; // Tháng hoặc quý
    private double revenue;

    // Định dạng số tiền hiển thị
    private static final DecimalFormat formatter = new DecimalFormat("#,### VND");

    // Constructor mới để lưu doanh thu
    public Order_list(int year, int period, double revenue) {
        this.year = year;
        this.period = period;
        this.revenue = revenue;
    }

    public Order_list(int OrderID, Date Date, double Total) {
        this.OrderID = OrderID;
        this.Date = Date;
        this.Total = Total;
    }

    
    public Order_list() {
    }

   

    public int getOrderID() {
        return OrderID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public int getStaffID() {
        return StaffID;
    }

    public String getAddress() {
        return Address;
    }

    public Date getDate() {
        return Date;
    }

    public String getStatus() {
        return Status;
    }

    public double getTotal() {
        return Total;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public void setStaffID(int StaffID) {
        this.StaffID = StaffID;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public void setTotal(double Total) {
        this.Total = Total;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public int getYear() {
        return year;
    }

    public int getPeriod() {
        return period;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    @Override
    public String toString() {
        if (year > 0) {
            // Nếu là dữ liệu doanh thu
            String type = (period > 12) ? "Quý" : "Tháng";
            return "Năm: " + year + ", " + type + ": " + period + ", Doanh thu: " + formatter.format(revenue);
        } else {
            // Nếu là dữ liệu đơn hàng
            return "Order ID: " + OrderID + ", Ngày: " + (Date != null ? Date.toString() : "Chưa có") +
                    ", Tổng tiền: " + formatter.format(Total);
        }
    }
}
