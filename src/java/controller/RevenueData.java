/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Order_list;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class RevenueData extends HttpServlet {

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
            out.println("<title>Servlet RevenueData</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueData at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String getYears = request.getParameter("getYears"); // Kiểm tra nếu yêu cầu lấy danh sách năm
        if (getYears != null && getYears.equals("true")) {
            sendYearList(response);
            return;
        }

        String filter = request.getParameter("filter");
        if (filter == null || filter.isEmpty()) {
            filter = "month"; // Mặc định nếu không có filter
        }

        List<Order_list> revenueList = new ArrayList<>();
        OrderDAO orderDAO = new OrderDAO();

        try {
            switch (filter) {
                case "month":
                    revenueList = orderDAO.getRevenueByMonth();
                    break;
                case "quarter":
                    revenueList = orderDAO.getRevenueByQuarter();
                    break;
                case "year":
                    revenueList = orderDAO.getRevenueByYear();
                    break;
                default:
                    System.out.println("Invalid filter: " + filter + ". Using default: month.");
                    revenueList = orderDAO.getRevenueByMonth();
            }

            if (revenueList == null || revenueList.isEmpty()) {
                response.getWriter().write("[]");
                return;
            }

            List<Map<String, Object>> formattedRevenueList = revenueList.stream()
                    .map(order -> {
                        Map<String, Object> data = new HashMap<>();
                        data.put("year", order.getYear());
                        data.put("period", order.getPeriod());
                        data.put("revenue", (long) order.getRevenue());
                        return data;
                    })
                    .collect(Collectors.toList());

            String json = new Gson().toJson(formattedRevenueList);
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal Server Error: " + e.getMessage() + "\"}");
        }
    }

// Hàm lấy danh sách năm từ database
    private void sendYearList(HttpServletResponse response) throws IOException {
        OrderDAO orderDAO = new OrderDAO();
        List<Integer> years = orderDAO.getAvailableYears(); // Lấy danh sách năm từ database

        if (years == null || years.isEmpty()) {
            response.getWriter().write("[]"); // Trả về danh sách rỗng nếu không có dữ liệu
            return;
        }

        String json = new Gson().toJson(years);
        response.getWriter().write(json);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.getWriter().write("{\"error\": \"POST method is not supported\"}");
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
