
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FeedbackDAO;
import dao.ProductDao;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import model.Customer;
import model.Feedback;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "feedback", urlPatterns = {"/feedback"})
public class feedback extends HttpServlet {

    private FeedbackDAO feedbackDAO;
    private ProductDao productDao;

    @Override
    public void init() {
        feedbackDAO = new FeedbackDAO();
        productDao = new ProductDao();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách feedback
        List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
        request.setAttribute("feedbackList", feedbackList);

        // Lấy danh sách CustomerName và lưu vào Map
        Map<Integer, String> customerNames = feedbackDAO.getCustomerNames();
        request.setAttribute("customerNames", customerNames); // Truyền map vào JSP

        Map<Integer, String> productNames = productDao.getProductNames(); // Lấy danh sách sản phẩm
        
        System.out.println("Danh sách productNames trong Servlet: " + productNames);
     
        request.setAttribute("productNames", productNames); // Đẩy lên JSP

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("viewAllFeedback.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("reply".equals(action)) {
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        String replyContent = request.getParameter("replyContent");

        // Lấy session
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role"); // "staff" hoặc "admin"
        
        int staffID = 0; // Mặc định admin sẽ có staffID = 0
        if ("staff".equals(role)) {
            staffID = (int) session.getAttribute("staffID");
        }

        // Gọi DAO để lưu phản hồi
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        feedbackDAO.replyToFeedback(feedbackID, customerID, staffID, replyContent);

        // Chuyển hướng sau khi gửi phản hồi thành công
        response.sendRedirect("feedback");
    }
}
}
