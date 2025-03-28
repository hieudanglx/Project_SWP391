package controller;

import dao.OrderDAO;
import dao.ProductDao;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import model.Product;

/**
 * @author Tran Phong Hai - CE180803
 */
@WebServlet("/RevenueTotal")
public class RevenueTotal extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] Bắt đầu doGet trong RevenueTotal Servlet");

        ProductDao productDao = new ProductDao();
        OrderDAO orderDao = new OrderDAO();
        HttpSession session = request.getSession();

        // Kiểm tra đăng nhập
        if (session.getAttribute("Username") == null) {
            System.out.println("[DEBUG] Chưa đăng nhập -> Chuyển hướng đến LoginOfDashboard.jsp");
            response.sendRedirect("LoginOfDashboard.jsp");
            return;
        }

        System.out.println("[DEBUG] Đã đăng nhập");

        // Lấy categoryId từ request, mặc định là 2
        int categoryId = 2;
        try {
            String categoryIdParam = request.getParameter("categoryId");
            if (categoryIdParam != null) {
                categoryId = Integer.parseInt(categoryIdParam);
            }
        } catch (NumberFormatException e) {
            System.out.println("[ERROR] categoryId không hợp lệ.");
        }

        System.out.println("[DEBUG] categoryId = " + categoryId);

        // Lấy danh sách sản phẩm bán chạy
        List<Product> products = productDao.getTopSellingProducts(categoryId);
        System.out.println("[DEBUG] Lấy danh sách sản phẩm thành công");
        request.setAttribute("products", products);

        // Lấy tổng doanh thu từ OrderDAO
        BigDecimal totalSales = orderDao.getTotalSales(); // Đảm bảo trả về kiểu long
        System.out.println("[DEBUG] Tổng doanh thu lấy từ DB: " + totalSales);

        // Kiểm tra giá trị totalSales để tránh lỗi khi format
       

        // Format số với dấu phẩy
        DecimalFormat df = new DecimalFormat("#,###");
        String formattedSales = df.format(totalSales);
        System.out.println("[DEBUG] Tổng doanh thu sau khi format: " + formattedSales);

        // Gửi dữ liệu sang JSP
        request.setAttribute("totalSales", formattedSales);

        // Lấy tổng sản phẩm & đơn hàng giao thành công
        int totalProducts = productDao.getTotalProduct();
        System.out.println("[DEBUG] Tổng sản phẩm: " + totalProducts);

        int totalOrderDelivery = productDao.getTotalOrderDelivery();
        System.out.println("[DEBUG] Tổng đơn hàng giao thành công: " + totalOrderDelivery);

        // Lưu vào session
        session.setAttribute("totalProducts", totalProducts);
        session.setAttribute("totalOrderDelivery", totalOrderDelivery);

        System.out.println("[DEBUG] Chuyển hướng đến HomeDashBoard_Admin.jsp");
        request.getRequestDispatcher("HomeDashBoard_Admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "RevenueTotal Servlet";
    }

    // Test trực tiếp phương thức getTotalSales()
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        BigDecimal totalSales = dao.getTotalSales();
        System.out.println("[TEST] Tổng doanh thu lấy từ DB: " + totalSales);

        DecimalFormat df = new DecimalFormat("#,###");
        String formattedSales = df.format(totalSales);
        System.out.println("[TEST] Tổng doanh thu sau khi format: " + formattedSales);
    }
}
