/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author nguye
 */
import java.sql.Connection;
import model.Feedback;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Map;

public class FeedbackDAO extends DBContext {

    // Lấy tất cả feedback
    public List<Feedback> getAllFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT FeedbackID, CustomerID, Content, RatePoint, ProductID FROM Feedback";

        try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback(
                        rs.getInt("FeedbackID"),
                        rs.getInt("CustomerID"),
                        rs.getString("Content"),
                        rs.getInt("RatePoint"),
                        rs.getInt("ProductID")
                );
                list.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Map<Integer, String> getCustomerNames() {
        Map<Integer, String> customerNames = new HashMap<>();
        String sql = "SELECT customerID, username FROM Customer";

        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("customerID");
                String username = rs.getString("username"); // Lấy username
                customerNames.put(id, username); // Lưu vào Map
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customerNames;
    }

    public void replyToFeedback(int feedbackID, int customerID, int staffID, String contentReply) {
        String sql = "INSERT INTO Reply_Feedback (feedbackID, customerID, staffID, contentReply) VALUES (?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ps.setInt(2, customerID);
            ps.setInt(3, staffID);
            ps.setString(4, contentReply);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy feedback theo ID
    public Feedback getFeedbackByID(int id) {
        String sql = "SELECT FeedbackID, CustomerID, Content, RatePoint, ProductID FROM Feedback WHERE FeedbackID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Feedback(
                            rs.getInt("FeedbackID"),
                            rs.getInt("CustomerID"),
                            rs.getString("Content"),
                            rs.getInt("RatePoint"),
                            rs.getInt("ProductID")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm feedback mới
    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (CustomerID, Content, RatePoint, ProductID) VALUES (?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, feedback.getCustomerID());
            stmt.setString(2, feedback.getContent());
            stmt.setInt(3, feedback.getRatePoint());
            stmt.setInt(4, feedback.getProductID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật feedback
    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE Feedback SET CustomerID = ?, Content = ?, RatePoint = ?, ProductID = ? WHERE FeedbackID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, feedback.getCustomerID());
            stmt.setString(2, feedback.getContent());
            stmt.setInt(3, feedback.getRatePoint());
            stmt.setInt(4, feedback.getProductID());
            stmt.setInt(5, feedback.getFeedbackID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa feedback theo ID
    public boolean deleteFeedback(int feedbackID) {
        String deleteRepliesSQL = "DELETE FROM Reply_Feedback WHERE feedbackID = ?";
        String deleteFeedbackSQL = "DELETE FROM Feedback WHERE feedbackID = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Xóa phản hồi liên quan trước
            try ( PreparedStatement psReplies = connection.prepareStatement(deleteRepliesSQL)) {
                psReplies.setInt(1, feedbackID);
                psReplies.executeUpdate();
            }

            // Xóa feedback
            try ( PreparedStatement psFeedback = connection.prepareStatement(deleteFeedbackSQL)) {
                psFeedback.setInt(1, feedbackID);
                int rowsAffected = psFeedback.executeUpdate();

                if (rowsAffected > 0) {
                    connection.commit(); // Nếu xóa thành công, commit thay đổi
                    return true;
                } else {
                    connection.rollback(); // Nếu không xóa được, rollback để tránh lỗi
                    return false;
                }
            }
        } catch (SQLException e) {
            try {
                connection.rollback(); // Nếu lỗi xảy ra, rollback tránh mất dữ liệu
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Đặt lại chế độ auto commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Feedback> getFeedbackByProductID(int productID) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT FeedbackID, CustomerID, Content, RatePoint, ProductID FROM Feedback WHERE ProductID = ?";

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Feedback fb = new Feedback(
                            rs.getInt("FeedbackID"),
                            rs.getInt("CustomerID"),
                            rs.getString("Content"),
                            rs.getInt("RatePoint"),
                            rs.getInt("ProductID")
                    );
                    list.add(fb);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Feedback> getFeedbackByProductID(int productID, Map<Integer, String> customerNames) {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT f.feedbackID, f.customerID, f.content, f.ratePoint, f.productID, c.fullname "
                + "FROM Feedback f "
                + "JOIN Customer c ON f.customerID = c.customerID "
                + "WHERE f.productID = ?";

        try (
                 PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, productID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt("feedbackID"),
                        rs.getInt("customerID"),
                        rs.getString("content"),
                        rs.getInt("ratePoint"),
                        rs.getInt("productID")
                );
                feedbackList.add(feedback);

                // ✅ Lưu tên khách hàng vào Map
                customerNames.put(feedback.getFeedbackID(), rs.getString("fullname"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbackList;
    }

}
