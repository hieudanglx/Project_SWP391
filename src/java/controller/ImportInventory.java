/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import static java.util.Calendar.DATE;
import java.util.List;
import model.Inventory;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
@WebServlet("/importInventory")
public class ImportInventory extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private InventoryDAO inventoryDAO;

    @Override
    public void init() {
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            Inventory inventory = inventoryDAO.getProductById(productID);

            if (inventory != null) {
                request.setAttribute("inventory", inventory);
                request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "❌ Không tìm thấy sản phẩm.");
                request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "❌ Mã sản phẩm không hợp lệ!");
            request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String productIDStr = request.getParameter("productID");
            String productName = request.getParameter("productName");
            String priceStr = request.getParameter("price");
            String importQuantityStr = request.getParameter("importQuantity");
            String importPriceStr = request.getParameter("importPrice");
            String supplier = request.getParameter("supplier");
            String importDateStr = request.getParameter("importDate");

            // Kiểm tra không để trống dữ liệu
            if (isEmpty(productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr)) {
                request.setAttribute("error", "❌ Vui lòng điền đầy đủ thông tin!");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
                return;
            }

            // Chuyển đổi dữ liệu
            int productID = Integer.parseInt(productIDStr);
            int price = Integer.parseInt(priceStr);
            int importQuantity = Integer.parseInt(importQuantityStr);
            int importPrice = Integer.parseInt(importPriceStr);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDate importLocalDate = LocalDate.parse(importDateStr, formatter);
            Date importDate = Date.valueOf(importLocalDate);
//            Date importDate = Date.valueOf(importDateStr);

            // Kiểm tra số lượng & giá nhập phải lớn hơn 0
            if (importQuantity <= 0 || importPrice <= 0) {
                request.setAttribute("error", "❌ Giá nhập và số lượng phải lớn hơn 0.");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
                return;
            }

            // Lấy giá bán của sản phẩm từ DB
            int sellingPrice = inventoryDAO.getSellingPrice(productID);
            if (sellingPrice == -1) {
                request.setAttribute("error", "❌ Không tìm thấy sản phẩm.");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
                return;
            }

            // Kiểm tra giá nhập không lớn hơn giá bán
            if (importPrice > sellingPrice) {
                request.setAttribute("error", "❌ Giá nhập không được lớn hơn giá bán (" + sellingPrice + ").");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
                return;
            }

            // Kiểm tra ngày nhập chỉ được là ngày hôm nay
            LocalDate today = LocalDate.now();
            Date currentDate = Date.valueOf(today);
            if (!importDate.equals(currentDate)) {
                request.setAttribute("error", "❌ Chỉ được nhập hàng vào ngày hôm nay!");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
                return;
            }

            // Nhập kho
            boolean success = inventoryDAO.importProduct(productID, importQuantity, importPrice, supplier, importDate);
            if (success) {
                List<Inventory> importList = inventoryDAO.getAllInventories();
                request.setAttribute("importList", importList);
                request.getSession().setAttribute("message", "✅ Nhập kho thành công!");
                request.getRequestDispatcher("viewlistInventory.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "❌ Lỗi khi nhập kho.");
                forwardWithInventory(request, response, productIDStr, productName, priceStr, importQuantityStr, importPriceStr, supplier, importDateStr);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "❌ Dữ liệu nhập không hợp lệ, vui lòng kiểm tra lại.");
            request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "❌ Ngày nhập không hợp lệ, vui lòng nhập đúng định dạng YYYY-MM-DD.");
            request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
        }
    }

    // Hàm kiểm tra chuỗi rỗng
    private boolean isEmpty(String... values) {
        for (String value : values) {
            if (value == null || value.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    // Hàm giữ lại thông tin sản phẩm khi nhập sai
    private void forwardWithInventory(HttpServletRequest request, HttpServletResponse response,
            String productIDStr, String productName, String priceStr,
            String importQuantityStr, String importPriceStr, String supplier, String importDateStr)
            throws ServletException, IOException, SQLException {
        int productID = Integer.parseInt(productIDStr);
        int price = priceStr != null && !priceStr.isEmpty() ? Integer.parseInt(priceStr) : inventoryDAO.getSellingPrice(productID);
        int importQuantity = importQuantityStr != null && !importQuantityStr.isEmpty() ? Integer.parseInt(importQuantityStr) : 0;
        int importPrice = importPriceStr != null && !importPriceStr.isEmpty() ? Integer.parseInt(importPriceStr) : 0;
        Date importDate = importDateStr != null && !importDateStr.isEmpty() ? Date.valueOf(importDateStr) : null;

        request.setAttribute("inventory", new Inventory(productID, productName, importDate, importPrice, price, productID, supplier));
        request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý nhập hàng vào kho";
    }
}
