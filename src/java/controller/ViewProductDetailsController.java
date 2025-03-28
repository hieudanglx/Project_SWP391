package controller;

import dao.FeedbackDAO;
import dao.ProductDao;
import dao.Reply_FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feedback;
import model.Product;
import model.Reply_Feedback;

@WebServlet(name = "ViewProductDetailsController", urlPatterns = {"/ViewProductDetailsController"})
public class ViewProductDetailsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        ProductDao productDao = new ProductDao();
        FeedbackDAO feedbackDao = new FeedbackDAO();
        Reply_FeedbackDAO reply_feedbackDAO = new Reply_FeedbackDAO();

        String idParam = (request.getParameter("id") == null
                || request.getParameter("id").isEmpty()) ? "0" : request.getParameter("id");
        int productID = Integer.parseInt(idParam);
        Product currentProduct = productDao.getProductByProductID(productID);
        String nameParam = (request.getParameter("name") == null
                || request.getParameter("name").isEmpty()) ? currentProduct.getProductName() : request.getParameter("name");

        List<Product> list = productDao.searchProductsByName(nameParam);

        String selectedRom = (request.getParameter("selectedRom") == null
                || request.getParameter("selectedRom").isEmpty()) ? currentProduct.getRom() : request.getParameter("selectedRom");
        String selectedColor = (request.getParameter("selectedColor") == null
                || request.getParameter("selectedColor").isEmpty()) ? currentProduct.getColor() : request.getParameter("selectedColor");

        Product selectedProduct = findProductByRomAndColor(list, selectedRom, selectedColor);
        if (selectedProduct == null) {
            selectedProduct = currentProduct;
        }
        request.setAttribute("list", list);

        Map<Integer, String> customerNames = feedbackDao.getCustomerNames();
        List<Feedback> feedbackList = feedbackDao.getFeedbackByProductID(selectedProduct.getProductID(), customerNames);
        List<Reply_Feedback> replyFeedbackList = reply_feedbackDAO.getAllReplyFeedback();

        request.setAttribute("replyFeedbackList", replyFeedbackList);
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
