package controller;

import dao.InventoryDAO;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Inventory;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Servlet xuất file Excel lịch sử nhập hàng
 * @author Tran Phong Hai - CE180803
 */
public class ExportImportHistory extends HttpServlet {

    private InventoryDAO inventoryDAO = new InventoryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportImportHistory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportImportHistory at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy productID từ request
        String productIDStr = request.getParameter("productID");
        Integer productID = null;
        if (productIDStr != null) {
            try {
                productID = Integer.parseInt(productIDStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("ImportHistory");
                return;
            }
        }

        // Lấy danh sách lịch sử nhập hàng
        List<Inventory> importHistory = inventoryDAO.getImportHistory(productID);
        
        // Tạo workbook và sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Import History");

        // Tạo hàng tiêu đề
        Row headerRow = sheet.createRow(0);
        String[] columnHeaders = {"Product ID", "Product Name", "Color", "Rom", "Brand",
                                  "Import Price", "Import Quantity", "Import Date", "Supplier"};
        
        CellStyle headerStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        headerStyle.setFont(font);

        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
            cell.setCellStyle(headerStyle);
        }

        // Định dạng số tiền (có dấu chấm phân cách hàng nghìn)
        CellStyle currencyStyle = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        currencyStyle.setDataFormat(format.getFormat("#,##0"));

        // Đổ dữ liệu vào các dòng tiếp theo
        int rowNum = 1;
        for (Inventory inventory : importHistory) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(inventory.getProductID());
            row.createCell(1).setCellValue(inventory.getProductName());
            row.createCell(2).setCellValue(inventory.getColor());
            row.createCell(3).setCellValue(inventory.getRom());
            row.createCell(4).setCellValue(inventory.getBrand());

            // Cột Import Price có định dạng số tiền
            Cell priceCell = row.createCell(5);
            priceCell.setCellValue(inventory.getImport_price());
            priceCell.setCellStyle(currencyStyle);

            row.createCell(6).setCellValue(inventory.getImport_quantity());
            row.createCell(7).setCellValue(inventory.getDATE().toString());
            row.createCell(8).setCellValue(inventory.getSupplier());
        }

        // Thiết lập tiêu đề response để tải file Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ImportHistory.xlsx");

        // Xuất file Excel ra output stream
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        }
        workbook.close();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xuất file Excel lịch sử nhập hàng";
    }
}
