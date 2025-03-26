/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author nguye
 */
import dao.FeedbackDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import model.Customer;
import model.Feedback;

@WebServlet("/SubmitReviewController")
public class SubmitReviewController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        // Kiểm tra đăng nhập
        if (customer == null) {
            session.setAttribute("errorMessage", "Bạn cần đăng nhập để gửi đánh giá!");
            response.sendRedirect("loginOfCustomer.jsp");
            return;
        }

        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int ratePoint = Integer.parseInt(request.getParameter("rating"));
            String content = request.getParameter("comment");

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Integer> productIDs = feedbackDAO.getProductIDsByOrderID(orderID);
            boolean success = true;

            for (int productID : productIDs) {
                Feedback feedback = new Feedback(customer.getCustomerID(), content, ratePoint, productID);
                if (!feedbackDAO.addFeedback(feedback)) {
                    success = false;
                }
            }

            if (success) {
                // Cập nhật trạng thái đơn hàng thành "Đã feedback"
                if (feedbackDAO.updateOrderStatus(orderID, "Đã đánh giá")) {
                    session.setAttribute("successMessage", "Đánh giá đã được gửi thành công và trạng thái đơn hàng đã được cập nhật!");
                } else {
                    session.setAttribute("errorMessage", "Đánh giá đã gửi nhưng không thể cập nhật trạng thái đơn hàng.");
                }
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi đánh giá, vui lòng thử lại.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi dữ liệu: " + e.getMessage());
        }

        response.sendRedirect("Order_History");
    }
}
