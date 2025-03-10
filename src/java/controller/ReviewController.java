///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package controller;
//
///**
// *
// * @author nguye
// */
//import dao.FeedbackDAO;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import model.Feedback;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/ReviewController")
//public class ReviewController extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    public ReviewController() {
//        super();
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Lấy productID từ request
//        String productIDStr = request.getParameter("productID");
//        if (productIDStr == null || productIDStr.isEmpty()) {
//            response.sendRedirect("error.jsp");
//            return;
//        }
//
//        int productID = Integer.parseInt(productIDStr);
//        
//        // Kết nối database và lấy danh sách đánh giá
//        FeedbackDAO feedbackDAO = new FeedbackDAO();
//        List<Feedback> feedbackList = feedbackDAO.getFeedbackByProductID(productID);
//        
//        // Đẩy danh sách đánh giá lên request
//        request.setAttribute("feedbackList", feedbackList);
//        request.setAttribute("productID", productID);
//        
//        // Forward tới JSP để hiển thị
//        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewProductDetails.jsp");
//        dispatcher.forward(request, response);
//    }
//}
