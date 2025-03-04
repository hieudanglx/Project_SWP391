/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import model.Order_list;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class OrderDAO extends dao.DBContext {

      public List<Order_list> getAllOrders() {
        String sql = "SELECT OrderID, Date, Total FROM Order_List";
        List<Order_list> orderList = new ArrayList<>();

        try ( PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int orderID = rs.getInt("OrderID");
                Date date = rs.getDate("Date");
                double total = rs.getInt("Total") * 1.0; // Chuyển int -> double

                // Làm tròn tổng tiền về 2 chữ số thập phân
                BigDecimal roundedTotal = new BigDecimal(total).setScale(2, RoundingMode.HALF_UP);

                // Thêm vào danh sách kết quả
                orderList.add(new Order_list(orderID, date, roundedTotal.doubleValue()));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }
     
    public List<Order_list> getRevenueByMonth() {
        String sql = "SELECT YEAR(ol.Date) AS Nam, MONTH(ol.Date) AS Thang, "
                + "SUM(od.Quantity * p.Price) AS DoanhThu "
                + "FROM Order_List ol "
                + "JOIN Order_Details od ON ol.OrderID = od.OrderID "
                + "JOIN Product p ON od.ProductID = p.ProductID "
                + "WHERE ol.Status IN ('Completed', 'Paid') "
                + "GROUP BY YEAR(ol.Date), MONTH(ol.Date) "
                + "ORDER BY Nam, Thang";
        return getRevenueData(sql, "month");
    }

    public List<Order_list> getRevenueByYear() {
        String sql = "SELECT YEAR(Date) AS Nam, SUM(Total) AS DoanhThu "
                + "FROM Order_List "
                + "WHERE Status IN ('Completed', 'Paid') "
                + "GROUP BY YEAR(Date) "
                + "ORDER BY Nam";
        return getRevenueData(sql, "year");
    }

    public List<Order_list> getRevenueByQuarter() {
        String sql = "SELECT YEAR(Date) AS Nam, "
                + "CASE "
                + "  WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 1 "
                + "  WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 2 "
                + "  WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 3 "
                + "  ELSE 4 "
                + "END AS Quy, "
                + "SUM(Total) AS DoanhThu "
                + "FROM Order_List "
                + "WHERE Status IN ('Completed', 'Paid') "
                + "GROUP BY YEAR(Date), "
                + "CASE "
                + "  WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 1 "
                + "  WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 2 "
                + "  WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 3 "
                + "  ELSE 4 "
                + "END "
                + "ORDER BY Nam, Quy";
        return getRevenueData(sql, "quarter");
    }

    private List<Order_list> getRevenueData(String sql, String type) {
        List<Order_list> revenueList = new ArrayList<>();
        try ( PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int year = rs.getInt("Nam");
                int period = (type.equals("year")) ? 0 : (type.equals("quarter") ? rs.getInt("Quy") : rs.getInt("Thang"));
                double revenue = rs.getDouble("DoanhThu");
                BigDecimal roundedRevenue = BigDecimal.valueOf(revenue).setScale(2, RoundingMode.HALF_UP);
                revenueList.add(new Order_list(year, period, roundedRevenue.doubleValue()));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueList;
    }

    public double getTotalSales() {
        double totalSales = 0;
        String sql = "SELECT SUM(Total) FROM Order_List WHERE Status IN ('Completed', 'Paid')";
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalSales = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSales;
    }

    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
        DecimalFormat df = new DecimalFormat("#,###.##");

        List<Order_list> orderList = orderDAO.getAllOrders();

        // Kiểm tra nếu danh sách rỗng
        if (orderList == null || orderList.isEmpty()) {
            System.out.println("Không có dữ liệu đơn hàng nào được tìm thấy!");
        } else {
            System.out.println("Danh sách đơn hàng:");
            for (Order_list order : orderList) {
                System.out.println("Order ID: " + order.getOrderID()
                        + ", Date: " + order.getDate()
                        + ", Total: " + order.getRevenue() + " VND");
            }
        }

        System.out.println("Doanh thu theo tháng:");
        for (Order_list order : orderDAO.getRevenueByMonth()) {
            System.out.println("Năm: " + order.getYear() + ", Tháng: " + order.getPeriod()
                    + ", Doanh thu: " + df.format(order.getRevenue()));
        }

        System.out.println("\nDoanh thu theo quý:");
        for (Order_list order : orderDAO.getRevenueByQuarter()) {
            System.out.println("Năm: " + order.getYear() + ", Quý: " + order.getPeriod()
                    + ", Doanh thu: " + df.format(order.getRevenue()));
        }

        System.out.println("\nDoanh thu theo năm:");
        for (Order_list order : orderDAO.getRevenueByYear()) {
            System.out.println("Năm: " + order.getYear() + ", Doanh thu: " + df.format(order.getRevenue()));
        }
    }
}
