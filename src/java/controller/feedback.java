
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.FeedbackDAO;
import dao.ProductDao;
import dao.Reply_FeedbackDAO;
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
import model.Reply_Feedback;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "feedback", urlPatterns = {"/feedback"})
public class feedback extends HttpServlet {

    private FeedbackDAO feedbackDAO;
    private ProductDao productDao;
    private Reply_FeedbackDAO reply_feedbackDAO;

    @Override
    public void init() {
        feedbackDAO = new FeedbackDAO();
        productDao = new ProductDao();
        reply_feedbackDAO = new Reply_FeedbackDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffId = (Integer) session.getAttribute("staffId");

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
                boolean isDeleted = feedbackDAO.deleteFeedback(feedbackID);

                if (isDeleted) {
                    session.setAttribute("repSuccess", "Xóa feedback thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa feedback. ID không tồn tại hoặc bị ràng buộc.");
                }
            } catch (Exception e) {
                session.setAttribute("errorMessage", "Lỗi xử lý xóa: " + e.getMessage());
                e.printStackTrace();
            }
            response.sendRedirect("feedback");
            return;
        }

        // Load danh sách feedback
        List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
        request.setAttribute("feedbackList", feedbackList);

        Map<Integer, String> customerNames = feedbackDAO.getCustomerNames();
        request.setAttribute("customerNames", customerNames);

        Map<Integer, String> productNames = productDao.getProductNames();
        request.setAttribute("productNames", productNames);
     
        Map<Integer, String> feedbackReplies = reply_feedbackDAO.getAllReplies();
        request.setAttribute("feedbackReplies", feedbackReplies);

        request.getRequestDispatcher("viewAllFeedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("reply".equals(action)) {
            int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            String staffIDStr = request.getParameter("staffID");

            if (staffIDStr == null || staffIDStr.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Lỗi! StaffID không hợp lệ.");
                response.sendRedirect("feedback");
                return;
            }

            int staffID = Integer.parseInt(staffIDStr);

            String content_Reply = request.getParameter("replyContent");

            boolean repSuccess = reply_feedbackDAO.replyToFeedback(feedbackID, customerID, staffID, content_Reply);
            System.out.println("Reply result: " + repSuccess);

            if (repSuccess) {
                session.setAttribute("repSuccess", "Phản hồi đã được gửi thành công!");
            } else {
                session.setAttribute("errorMessage", "Lỗi! Không thể gửi phản hồi.");
            }

            response.sendRedirect("feedback");
        }
    }

}
