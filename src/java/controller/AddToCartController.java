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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    CartDao link = new CartDao();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        // Kiểm tra đăng nhập
        if (customer == null) {
            response.sendRedirect("choiceLogin.jsp");
            return;
        }

        String status = "success";
        String message = "Thêm vào giỏ hàng thành công";

        // Parse tham số
        String quantityParam = request.getParameter("Quantity");
        int quantity = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1;
        int productId = Integer.parseInt(request.getParameter("id"));

        // Xử lý logic chính
        if (quantity <= 0) {
            status = "error";
            message = "Số lượng không hợp lệ";
        } else {
            int quantityInCart = link.productExistsInCart(customer.getCustomerID(), productId);
            if (quantityInCart == 0) {
                link.addProductToCart(customer.getCustomerID(), productId);
            } else if (quantity > quantityInCart) {
                link.updateCartQuantity(customer.getCustomerID(), productId, quantityInCart + 1);
            } else {
                status = "error";
                message = "Số lượng vượt quá tồn kho";
            }
        }

        // Xác định URL và cập nhật session
        String redirectUrl = determineRedirectUrl(request, productId);
        session.setAttribute("status", status);
        session.setAttribute("message", message);
        session.setAttribute("size", link.getTotalItems(customer.getCustomerID()));
        session.setAttribute("total", link.getTotalCartValue(customer.getCustomerID()));
        request.getRequestDispatcher(redirectUrl).forward(request, response);
    }

    private String determineRedirectUrl(HttpServletRequest request, int productId) {
        String web = request.getParameter("web") != null ? request.getParameter("web") : "";
        String categoryId = request.getParameter("CategoryID");

        if (web.contains("list") && categoryId != null) {
            return "ViewListProductGC?CategoryID=" + categoryId;
        }
        return web.contains("detail") ? "ViewProductDetailsController?id=" + productId : "ViewCartController";
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
            Logger.getLogger(AddToCartController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddToCartController.class.getName()).log(Level.SEVERE, null, ex);
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
