/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order_list;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class ExportRevenue extends HttpServlet {

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
            out.println("<title>Servlet ExportRevenue</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportRevenue at " + request.getContextPath() + "</h1>");
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

        String filter = request.getParameter("filter");
        OrderDAO orderDAO = new OrderDAO();
        List<Order_list> revenueList = null;

        if ("month".equals(filter)) {
            revenueList = orderDAO.getRevenueByMonth();
        } else if ("quarter".equals(filter)) {
            revenueList = orderDAO.getRevenueByQuarter();
        } else if ("year".equals(filter)) {
            revenueList = orderDAO.getRevenueByYear();
        } else {
            revenueList = orderDAO.getAllOrders();
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=revenue.xlsx");

        try ( Workbook workbook = new XSSFWorkbook();  ServletOutputStream out = response.getOutputStream()) {
            Sheet sheet = workbook.createSheet("Revenue Data");
            Row headerRow = sheet.createRow(0);

            // Tạo tiêu đề cột
            headerRow.createCell(0).setCellValue("Năm");
            if ("month".equals(filter)) {
                headerRow.createCell(1).setCellValue("Tháng");
                headerRow.createCell(2).setCellValue("Doanh Thu");
            } else if ("quarter".equals(filter)) {
                headerRow.createCell(1).setCellValue("Quý");
                headerRow.createCell(2).setCellValue("Doanh Thu");
            } else if ("year".equals(filter)) {
                headerRow.createCell(1).setCellValue("Doanh Thu");
            } else {
                headerRow.createCell(1).setCellValue("Ngày");
                headerRow.createCell(2).setCellValue("Tổng tiền");
            }

            // Điền dữ liệu
            int rowNum = 1;
            for (Order_list order : revenueList) {
                Row row = sheet.createRow(rowNum++);
                if ("month".equals(filter) || "quarter".equals(filter) || "year".equals(filter)) {
                    row.createCell(0).setCellValue(order.getYear());
                } else {
                    row.createCell(0).setCellValue(order.getDate().toLocalDate().getYear());
                }

                if ("month".equals(filter)) {
                    row.createCell(1).setCellValue(order.getPeriod()); // Tháng
                    row.createCell(2).setCellValue(order.getRevenue()); // Doanh thu
                } else if ("quarter".equals(filter)) {
                    row.createCell(1).setCellValue(order.getPeriod()); // Quý
                    row.createCell(2).setCellValue(order.getRevenue());
                } else if ("year".equals(filter)) {
                    row.createCell(1).setCellValue(order.getRevenue());
                } else {
                    row.createCell(1).setCellValue(order.getDate().toString()); // Ngày
                    row.createCell(2).setCellValue(order.getTotal());
                }
            }
            workbook.write(out);
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
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
