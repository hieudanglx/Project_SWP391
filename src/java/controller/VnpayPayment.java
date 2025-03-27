/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.CartDao;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import model.Customer;
import model.Order_Details;
import model.Order_list;
import model.Product;

/**
 *
 * @author TRAN NHU Y -  CE182032
 */
@WebServlet(name = "VnpayPayment", urlPatterns = {"/VnpayPayment"})
public class VnpayPayment extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
             try {
                HttpSession session = request.getSession();
                CartDao link = new CartDao();
                Customer c = (Customer) session.getAttribute("customer"); // Lấy thông tin khách hàng
                List<Product> list = link.getCartByCustomerID(c.getCustomerID());

               

                int customerID = c.getCustomerID();
                Integer staffID = null;
               
              
                String address = (String) session.getAttribute("address");

                String status = "Chờ xử lý";
                Date Date = new Date(System.currentTimeMillis()); // Lấy ngày hiện tại

                String phoneNumber = (String) session.getAttribute("phoneNumber");

                double total = (double) session.getAttribute("total");

              
                    // Thêm đơn hàng vào Order_list
                    OrderDAO orderDAO = new OrderDAO();

                    Order_list order = new Order_list(0, customerID, 1, address, Date, status, phoneNumber, total);
                    int orderID = orderDAO.insertOrder(order); // Lưu đơn hàng và lấy ID
                    session.setAttribute("orderID", orderID);
                    if (orderID > 0) {
                        // Thêm sản phẩm vào Order_Details
                        for (Product item : list) {
                            Order_Details orderDetail = new Order_Details(0, item.getQuantityProduct(), item.getProductID(), orderID);
                            orderDAO.insertOrderDetail(orderDetail);

                        }
                        orderDAO.updateProductQuantity(orderID);

                        // Xóa giỏ hàng sau khi đặt hàng thành công
                        CartDao cartDao = new CartDao();
                        cartDao.clearCart(c.getCustomerID());
                        session.setAttribute("size", 0); // Đặt biến size vào session

                        //  Double totals = (Double) session.getAttribute("total");
                        session.setAttribute("total", 0);

                        // Xóa session giỏ hàng
                        session.removeAttribute("list");

                        // Chuyển hướng sang trang xác nhận                
                        request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Failed to delete product");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp?error=Lỗi hệ thống");
            }
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
