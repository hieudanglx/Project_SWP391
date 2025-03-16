/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
public class Feedback {
    private int feedbackID;
    private int customerID;
    private String content;
    private int ratePoint;
    private int productID;

    public Feedback() {
    }

    public Feedback(int feedbackID, int customerID, String content, int ratePoint, int productID) {
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.content = content;
        this.ratePoint = ratePoint;
        this.productID = productID;
    }

    public Feedback(int customerID, String content, int ratePoint, int productID) {
        this.customerID = customerID;
        this.content = content;
        this.ratePoint = ratePoint;
        this.productID = productID;
    }

   

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRatePoint() {
        return ratePoint;
    }

    public void setRatePoint(int ratePoint) {
        this.ratePoint = ratePoint;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

}