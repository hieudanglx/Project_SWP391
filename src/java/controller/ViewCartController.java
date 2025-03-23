/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CartDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.Product;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
@WebServlet(name = "ViewCartController", urlPatterns = {"/ViewCartController"})
public class ViewCartController extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        CartDao link = new CartDao();
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("choiceLogin.jsp");
            return;
        }

        int check = 0;
        List<Product> cartItems = link.getCartByCustomerID(customer.getCustomerID());
        for (Product product : cartItems) {
            int stockQuantity = link.getProductQuantity(product.getProductID());
            if (stockQuantity == 0) {
                // Nếu sản phẩm hết hàng, xóa khỏi giỏ
                check++;
                link.removeProductFromCart(customer.getCustomerID(), product.getProductID());
            } else if (product.getQuantityProduct() > stockQuantity) {
                // Nếu số lượng trong giỏ lớn hơn số lượng tồn kho, cập nhật lại số lượng trong giỏ
                link.updateCartQuantity(customer.getCustomerID(), product.getProductID(), stockQuantity);
                check++;
            }
        }
        if (check != 0) {
            String status = "waring";
            String message = "Cart đã được cập nhật do " + check + " sản phẩm của bạn đã thay đổi số lượng";
            session.setAttribute("status", status);
            session.setAttribute("message", message);
        }

        request.setAttribute("list", cartItems);
        session.setAttribute("size", link.getTotalItems(cartItems, customer.getCustomerID()));
        session.setAttribute("total", link.getTotalCart(cartItems, customer.getCustomerID()));
        request.getRequestDispatcher("viewCart.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewCartController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewCartController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
