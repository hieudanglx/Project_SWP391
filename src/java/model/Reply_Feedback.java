/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
public class Reply_Feedback {
    private int replyFeedbackID;
    private int feedbackID;
    private int customerID;
    private int staffID;
    private String contentReply;

    public Reply_Feedback() {
    }

    public Reply_Feedback(int replyFeedbackID, int feedbackID, int customerID, int staffID, String contentReply) {
        this.replyFeedbackID = replyFeedbackID;
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.staffID = staffID;
        this.contentReply = contentReply;
    }

    public int getReplyFeedbackID() {
        return replyFeedbackID;
    }

    public void setReplyFeedbackID(int replyFeedbackID) {
        this.replyFeedbackID = replyFeedbackID;
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

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getContentReply() {
        return contentReply;
    }

    public void setContentReply(String contentReply) {
        this.contentReply = contentReply;
    }
    
}
