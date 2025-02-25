/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Product;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
@WebServlet(name = "ViewListProductGCController", urlPatterns = {"/ViewListProductGC"})
public class ViewListProductGCController extends HttpServlet {

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
        ProductDao link = new ProductDao();
        int categoryID = 0; // Đổi tên biến cho đúng chính tả

        // Xử lý tham số an toàn
        String categoryIdParam = request.getParameter("CategoryID");
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryID = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                // Xử lý trường hợp giá trị không phải số
                request.setAttribute("error", "ID danh mục không hợp lệ");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        } else {
            // Xử lý trường hợp không có CategoryID
            request.setAttribute("error", "Thiếu tham số CategoryID");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        List<String> brand = link.getBrandbyCategoryID(categoryID);
        List<Product> list = link.getProductByCategoryID(categoryID);

        if (list.isEmpty()) {
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("CategoryID", categoryID); // Sửa tên attribute
        request.setAttribute("listbrand", brand);
        request.setAttribute("list", list);
        request.getRequestDispatcher("viewListProductGC.jsp").forward(request, response);
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
            request.setAttribute("err", ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
            request.setAttribute("err", ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
