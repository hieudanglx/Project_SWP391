/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.InventoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.Date;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class importExcel extends HttpServlet {

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
            out.println("<title>Servlet importExcel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet importExcel at " + request.getContextPath() + "</h1>");
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
    private InventoryDAO inventoryDAO;

    @Override
    public void init() {
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("file");
        InputStream fileContent = filePart.getInputStream();

        try ( Workbook workbook = new XSSFWorkbook(fileContent)) {
            Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên
            for (Row row : sheet) {
                if (row.getRowNum() == 0) {
                    continue; // Bỏ qua tiêu đề
                }

                // Đọc dữ liệu từ file Excel
                int productID = (int) Math.round(row.getCell(0).getNumericCellValue()); // Fix lỗi kiểu dữ liệu
                int importQuantity = (int) Math.round(row.getCell(1).getNumericCellValue());
                int importPrice = (int) Math.round(row.getCell(2).getNumericCellValue());
                String supplier = row.getCell(3).getStringCellValue();
                Date importDate;

                try {
                    importDate = new Date(row.getCell(4).getDateCellValue().getTime()); // Chuyển đổi ngày
                } catch (Exception e) {
                    request.setAttribute("error", "❌ Lỗi định dạng ngày cho sản phẩm ID: " + productID);
                    request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra sản phẩm có tồn tại không
                int sellingPrice = inventoryDAO.getSellingPrice(productID);
                if (sellingPrice == -1) {
                    request.setAttribute("error", "❌ Sản phẩm ID: " + productID + " không tồn tại trong hệ thống.");
                    request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
                    return;
                }

                // Kiểm tra giá nhập có hợp lệ không
                if (importPrice > sellingPrice) {
                    request.setAttribute("error", "❌ Giá nhập cao hơn giá bán cho sản phẩm ID: " + productID);
                    request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
                    return;
                }

                // Thực hiện nhập kho
                boolean success = inventoryDAO.importProduct(productID, importQuantity, importPrice, supplier, importDate);
                if (!success) {
                    request.setAttribute("error", "❌ Nhập kho thất bại cho sản phẩm ID: " + productID);
                    request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
                    return;
                }
            }

            // Nếu nhập thành công, chuyển hướng về danh sách kho hàng
            request.getSession().setAttribute("successMessage", "✅ Nhập hàng thành công!");
            response.sendRedirect("ListInventory");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi xử lý file Excel: " + e.getMessage());
            request.getRequestDispatcher("import_inventory.jsp").forward(request, response);
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
