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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
@WebServlet(name = "ViewProductDetailsController", urlPatterns = {"/ViewProductDetailsController"})
public class ViewProductDetailsController extends HttpServlet {

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
        int productID = Integer.parseInt(request.getParameter("id"));
        String selectedRom = request.getParameter("selectedRom");
        String selectedColor = request.getParameter("selectedColor");

        Product currentProduct = link.getProductById(productID);
        List<Product> list = link.searchProductsByName(currentProduct.getProductName());

        Product selectedProduct = null;

        // Kiểm tra nếu danh sách có 2 phiên bản và không mix ROM/Color
        if (list.size() == 2) {
            Product p1 = list.get(0);
            Product p2 = list.get(1);

            // Nếu 2 phiên bản có ROM và Color riêng
            if (!p1.getRom().equals(p2.getRom()) && !p1.getColor().equals(p2.getColor())) {
                // Tự động chọn phiên bản dựa trên ROM/Color được chọn
                if (selectedRom != null) {
                    for (Product p : list) {
                        if (p.getRom().equals(selectedRom)) {
                            selectedProduct = p;
                            break;
                        }
                    }
                } else if (selectedColor != null) {
                    for (Product p : list) {
                        if (p.getColor().equals(selectedColor)) {
                            selectedProduct = p;
                            break;
                        }
                    }
                }
            } else {
                // Xử lý trường hợp khác
                selectedProduct = findProductByRomAndColor(list, selectedRom, selectedColor);
            }
        } else {
            // Xử lý trường hợp thông thường
            selectedProduct = findProductByRomAndColor(list, selectedRom, selectedColor);
        }

        if (selectedProduct == null) {
            selectedProduct = currentProduct;
        }

        request.setAttribute("product", selectedProduct);
        request.setAttribute("list", list);
        request.getRequestDispatcher("ViewProductDetails.jsp").forward(request, response);
    }

    private Product findProductByRomAndColor(List<Product> list, String rom, String color) {
        for (Product p : list) {
            boolean romMatch = (rom == null) || p.getRom().equals(rom);
            boolean colorMatch = (color == null) || p.getColor().equals(color);
            if (romMatch && colorMatch) {
                return p;
            }
        }
        return null;
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
            Logger.getLogger(ViewProductDetailsController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ViewProductDetailsController.class.getName()).log(Level.SEVERE, null, ex);
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
