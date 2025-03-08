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

        int productID = Integer.parseInt(request.getParameter("id"));
        String selectedRom = request.getParameter("selectedRom");
        String selectedColor = request.getParameter("selectedColor");

        Product currentProduct = productDao.getProductById(productID);
        List<Product> list = productDao.searchProductsByName(currentProduct.getProductName());

        Product selectedProduct = findProductByRomAndColor(list, selectedRom, selectedColor);
        if (selectedProduct == null) {
            selectedProduct = currentProduct;
        }

        // ✅ Tạo Map lưu tên khách hàng
        Map<Integer, String> customerNames = new HashMap<>();
        List<Feedback> feedbackList = feedbackDao.getFeedbackByProductID(productID, customerNames);

        request.setAttribute("product", selectedProduct);
        request.setAttribute("list", list);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("customerNames", customerNames); // ✅ Gửi Map sang JSP

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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ViewProductDetailsController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
