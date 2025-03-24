/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import dao.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order_list;
import model.Product;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class Top_selling extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Top_selling</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Top_selling at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        ProductDao pd = new ProductDao();
        OrderDAO orderDao = new OrderDAO();
        String categoryIdParam = request.getParameter("categoryId");
        int categoryId = (categoryIdParam != null) ? Integer.parseInt(categoryIdParam) : 1; // Mặc định là 1
        List<Product> products = pd.getTopSellingProducts(categoryId);

        List<Order_list> recentOrders =orderDao.getOrdernew();
        
        request.setAttribute("products", products);
        request.setAttribute("selectedCategory", categoryId);
        request.setAttribute("recentOrder", recentOrders);

        // 🛠 Lấy tổng số sản phẩm từ DB
        int totalProduct = pd.getTotalProduct();
        int totalOrderSuccessful = pd.getTotalPendingOrder();
        int TotalOrderDelivery = pd.getTotalOrderDelivery();
        
        
        HttpSession session = request.getSession();
        session.setAttribute("totalProducts", totalProduct); // Lưu vào session
        session.setAttribute("totalOrderSuccessful", totalOrderSuccessful);
        session.setAttribute("TotalOrderDelivery", TotalOrderDelivery);
        
        

        request.getRequestDispatcher("HomeDashBoard_Staff.jsp").forward(request, response);
        request.getRequestDispatcher("HomeDashBoard_Admin.jsp").forward(request, response);
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
