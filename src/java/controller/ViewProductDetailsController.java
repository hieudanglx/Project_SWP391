package controller;

import dao.FeedbackDAO;
import dao.ProductDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Product;

@WebServlet(name = "ViewProductDetailsController", urlPatterns = {"/ViewProductDetailsController"})
public class ViewProductDetailsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        ProductDao productDao = new ProductDao();
        FeedbackDAO feedbackDao = new FeedbackDAO();

        String idParam = (request.getParameter("id") == null
                || request.getParameter("id").isEmpty()) ? "0" : request.getParameter("id");
        int productID = Integer.parseInt(idParam);
        Product currentProduct = productDao.getProductById(productID);

        String selectedRom = (request.getParameter("selectedRom") == null
                || request.getParameter("selectedRom").isEmpty()) ? currentProduct.getRom() : request.getParameter("selectedRom");
        String selectedColor = (request.getParameter("selectedColor") == null
                || request.getParameter("selectedColor").isEmpty()) ? currentProduct.getColor() : request.getParameter("selectedColor");

        List<Product> list = productDao.searchProductsByName(currentProduct.getProductName());

        Product selectedProduct = findProductByRomAndColor(list, selectedRom, selectedColor);
        if (selectedProduct == null) {
            selectedProduct = currentProduct;
        } else if (list.size() > 3) {
            request.setAttribute("list", list);
        }

        Map<Integer, String> customerNames = new HashMap<>();
        List<Feedback> feedbackList = feedbackDao.getFeedbackByProductID(productID, customerNames);

        request.setAttribute("product", selectedProduct);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("customerNames", customerNames);
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewProductDetailsController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewProductDetailsController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống!");
        }
    }

    @Override
    public String getServletInfo() {
        return "ViewProductDetailsController";
    }
}
