/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order_Details;
import model.Order_list;

/**
 *
 * @author Dang Khac Hieu_CE180465
 */
@WebServlet(name = "Order_History", urlPatterns = {"/Order_History"})
public class Order_History extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public Order_History() {
        super();
        orderDAO = new OrderDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Order_History</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Order_History at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    
    // Lấy customerID từ session
    Integer customerID = (Integer) session.getAttribute("customerID");

//        System.out.println(customerID);
    

    // Gọi hàm lấy danh sách đơn hàng của khách hàng
    List<Order_Details> orderDetails = orderDAO.getOrdersByCustomer(customerID);
//        System.out.println(orderDetails);
//    if (orderDetails.isEmpty()) {
//        request.setAttribute("error.","rong" );
//        request.getRequestDispatcher("error.jsp").forward(request, response);
//    }

    

    
    // Đưa danh sách đơn hàng vào request attribute
    request.setAttribute("orderDetails", orderDetails);

    // Chuyển hướng đến trang lịch sử đơn hàng
    request.getRequestDispatcher("OrderHistory.jsp").forward(request, response);
}

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
