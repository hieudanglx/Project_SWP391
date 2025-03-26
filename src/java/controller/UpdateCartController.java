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
@WebServlet(name = "UpdateCartController", urlPatterns = {"/UpdateCartController"})
public class UpdateCartController extends HttpServlet {

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
        CartDao link = new CartDao();

        Customer c = (Customer) session.getAttribute("customer");

        // Kiểm tra tham số bắt buộc
        String type = request.getParameter("type");
        String idParam = request.getParameter("id");

        int id = Integer.parseInt(idParam);
        String status = "success";
        String message = "Cập nhật thành công";
        // Xử lý logic
        switch (type) {
            case "-":
                if (!link.updateCartProduct(c.getCustomerID(), id, type)) {
                    System.out.println("controller.UpdateCartController.processRequest() add sai r");
                    status = "error";
                    message = "Cập nhật thất bại";
                }
                break;
            case "E":
                String quantityParam = request.getParameter("Quantity");
                double quantity = Double.parseDouble(quantityParam);
                int stock = link.getProductQuantity(id);
                if (stock >= quantity) {
                    link.updateCartQuantity(c.getCustomerID(), id, (int) quantity);
                } else {
                    status = "error";
                    message = "Số lượng vượt quá tồn kho";
                }
                break;
        }
        // Cập nhật session
        session.setAttribute("status", status);
        session.setAttribute("message", message);
         List<Product> cartItems = link.getCartByCustomerID(c.getCustomerID());
        request.setAttribute("list", cartItems);
        session.setAttribute("size", link.getTotalItems(cartItems, c.getCustomerID()));
        session.setAttribute("total", link.getTotalCart(cartItems, c.getCustomerID()));
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
            Logger.getLogger(UpdateCartController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UpdateCartController.class.getName()).log(Level.SEVERE, null, ex);
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
