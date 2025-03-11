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
import java.util.ArrayList;
import java.util.List;
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
            throws ServletException, IOException {
        CartDao link = new CartDao();
        HttpSession session = request.getSession();
        String type = request.getParameter("type");
        String page = request.getParameter("page");
        int id = Integer.parseInt(request.getParameter("id"));
        Customer c = (Customer) session.getAttribute("customer");
        if (c == null) {
            response.sendRedirect("choiceLogin.jsp"); // hoặc trang thông báo
            return;
        }
        String url = "ViewCartController";
        switch (type) {
            case "R":
                link.removeProductFromCart(c.getCustomerID(), id);
                break;
            case "add":
                request.setAttribute("status", true);
                if (!link.AddProductToCart(c.getCustomerID(), id)) {
                    System.out.println("controller.UpdateCartController.processRequest() add sai r");
                    request.setAttribute("status", false);
                }
                if (page.contains("list")) {
                    url = "ViewListProductGC?CategoryID="+Integer.parseInt(request.getParameter("CategoryID"));
                } else {
                    url = "ViewProductDetailsController?id=" + id;
                }
                System.out.println("link: " + url);
                break;
            case "buy":
                if (!link.AddProductToCart(c.getCustomerID(), id)) {
                    System.out.println("controller.UpdateCartController.processRequest() buy sai r");
                }
                break;
            default:
                link.updateCartProduct(c.getCustomerID(), id, type);
                break;
        }
        List<Product> list = new ArrayList<>();
        session.setAttribute("size", link.getTotalItems(list, c.getCustomerID()));
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
        processRequest(request, response);
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
