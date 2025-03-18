/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Feedback;
import model.Reply_Feedback;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
public class Reply_FeedbackDAO extends DBContext {

    public boolean replyToFeedback(int feedbackID, int customerID, int staffID, String content_Reply) {
        String sql = "INSERT INTO Reply_Feedback ([feedbackID], [customerID], [staffID], [content_Reply]) VALUES (?, ?, ?, ?)";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ps.setInt(2, customerID);
            ps.setInt(3, staffID);
            ps.setString(4, content_Reply);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có dòng được thêm thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }

    public Map<Integer, String> getAllReplies() { 
        Map<Integer, String> replies = new HashMap<>();
        String sql = "SELECT feedbackID, content_Reply FROM Reply_Feedback";

        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                replies.put(rs.getInt("feedbackID"), rs.getString("content_Reply"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    public List<Reply_Feedback> getAllReplyFeedback() {
        List<Reply_Feedback> list = new ArrayList<>();
        String sql = "SELECT reply_FeedbackID, FeedbackID, CustomerID, StaffID, Content_Reply FROM Reply_Feedback";

        try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Reply_Feedback fb = new Reply_Feedback(
                        rs.getInt("reply_FeedbackID"),
                        rs.getInt("FeedbackID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("StaffID"),
                        rs.getString("Content_Reply")
                );
                list.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
