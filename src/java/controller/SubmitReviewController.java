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
import model.Customer;
import model.Feedback;


@WebServlet("/SubmitReviewController")
public class SubmitReviewController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            session.setAttribute("errorMessage", "Bạn cần đăng nhập để gửi đánh giá!");
            response.sendRedirect("Login.jsp");
            return;
        }

        int productID = Integer.parseInt(request.getParameter("productID"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Feedback feedback = new Feedback(customer.getCustomerID(),comment,rating, productID+"");
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        if (feedbackDAO.addFeedback(feedback)) {
            session.setAttribute("successMessage", "Đánh giá đã được gửi thành công!");
        } else {
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi đánh giá, vui lòng thử lại.");
        }

        response.sendRedirect("ViewProductDetailsController?id=" + productID);
    }
}
