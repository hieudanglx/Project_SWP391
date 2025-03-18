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
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession();
        CartDao link = new CartDao();
        
        Customer c = (Customer) session.getAttribute("customer");
        if (c == null) {
            response.sendRedirect("choiceLogin.jsp");
            return;
        }

        // Kiểm tra tham số bắt buộc
        String type = request.getParameter("type");
        String page = (request.getParameter("page") == null
                || request.getParameter("page").isEmpty()) ? "" : request.getParameter("page");
        String idParam = request.getParameter("id");
        String categoryIDParam = (request.getParameter("CategoryID") == null
                || request.getParameter("CategoryID").isEmpty()) ? "" : request.getParameter("CategoryID");

        int id = Integer.parseInt(idParam);
        String url = "ViewCartController"; // Mặc định

        // Xử lý URL redirect
        if (page.contains("list") && categoryIDParam != null) {
            url = "ViewListProductGC?CategoryID=" + Integer.parseInt(categoryIDParam);
        } else if (page.contains("detail")) {
            url = "ViewProductDetailsController?id=" + id;
        }
        System.out.println(url);
        // Xử lý logic
        switch (type) {
            case "R":
                link.removeProductFromCart(c.getCustomerID(), id);
                break;
            default:
                request.setAttribute("status", true);
                if (link.ProductExistsInCart(c.getCustomerID(), id)) {
                    System.out.println("controller.ProductExistsInCart.processRequest() ton tai r");
                    if (!link.updateCartProduct(c.getCustomerID(), id, type)) {
                        System.out.println("controller.UpdateCartController.processRequest() add sai r");
                        request.setAttribute("status", false);
                    }
                } else {
                    if (!link.AddProductToCart(c.getCustomerID(), id)) {
                        System.out.println("controller.AddProductToCart.processRequest() add sai r");
                        request.setAttribute("status", false);
                    }
                }
                break;
        }
        int total = 0, size= 0;
        // Cập nhật session
        List<Product> list = new ArrayList<>();
        total = link.getTotalCart(list, c.getCustomerID());
        size = link.getTotalItems(list, c.getCustomerID()); // Sửa lại phương thức
        session.setAttribute("size", size);
        session.setAttribute("total", total);
        request.getRequestDispatcher(url).forward(request, response);

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
