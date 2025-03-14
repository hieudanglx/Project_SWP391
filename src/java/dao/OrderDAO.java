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
import model.OrderDetailForAdmin;
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

    public List<Order_list> getAllOrder() {
        List<Order_list> orderList = new ArrayList<>();
        String query = "SELECT * FROM Order_List"; // Giả sử bảng đơn hàng có tên là "Orders"

        try ( PreparedStatement pstmt = connection.prepareStatement(query);  ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Order_list order = new Order_list(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("StaffID"),
                        rs.getString("Address"),
                        rs.getDate("Date"), // Hoặc rs.getTimestamp("Date") nếu là kiểu datetime
                        rs.getString("Status"),
                        rs.getString("PhoneNumber"),
                        rs.getDouble("Total")
                );
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }

    public boolean updateOrderStatus(int orderID, String newStatus) {
        String query = "UPDATE Order_List SET Status = ? WHERE OrderID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, orderID);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public void restoreProductQuantity(int orderID) {
    String selectQuery = "SELECT ProductID, Quantity FROM Order_Details WHERE OrderID = ?";
    String updateQuery = "UPDATE Product SET Quantity_Product = Quantity_Product + ? WHERE ProductID = ?";
    
    try (PreparedStatement pstmtSelect = connection.prepareStatement(selectQuery);
         PreparedStatement pstmtUpdate = connection.prepareStatement(updateQuery)) {
        
        pstmtSelect.setInt(1, orderID);
        ResultSet rs = pstmtSelect.executeQuery();
        
        while (rs.next()) {
            int productID = rs.getInt("ProductID");
            int quantity = rs.getInt("Quantity");
            
            pstmtUpdate.setInt(1, quantity);
            pstmtUpdate.setInt(2, productID);
            pstmtUpdate.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public List<Order_list> getOrdersByStatus(String status) {
        List<Order_list> orderList = new ArrayList<>();
        String query = "SELECT * FROM Order_List WHERE Status = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order_list order = new Order_list(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("StaffID"),
                        rs.getString("Address"),
                        rs.getDate("Date"), // Hoặc rs.getTimestamp("Date") nếu là kiểu datetime
                        rs.getString("Status"),
                        rs.getString("PhoneNumber"),
                        rs.getDouble("Total")
                );
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }
    public List<OrderDetailForAdmin> getOrderDetails(int orderID) {
    List<OrderDetailForAdmin> orderDetailsList = new ArrayList<>();
    String query = "SELECT o.OrderID, o.Address, o.Date, o.Status, o.Total, o.PhoneNumber, " +
                   "c.FullName , s.FullName, " +
                   "od.Quantity, p.ProductName, p.Price, p.Color " +
                   "FROM Order_List o " +
                   "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                   "JOIN Order_Details od ON o.OrderID = od.OrderID " +
                   "JOIN Product p ON od.ProductID = p.ProductID " +
                   "JOIN Staff s ON o.StaffID = s.StaffID " +
                   "WHERE o.OrderID = ?";

    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
        pstmt.setInt(1, orderID);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            orderDetailsList.add(new OrderDetailForAdmin(
                rs.getInt("OrderID"),
                rs.getString("Address"),
                rs.getDate("Date"),
                rs.getString("Status"),
                rs.getDouble("Total"),
                rs.getString("PhoneNumber"),
                rs.getString("FullName"),
                rs.getString("FullName"),
                rs.getInt("Quantity"),
                rs.getString("ProductName"),
                rs.getInt("Price"),
                rs.getString("Color")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return orderDetailsList;
}


    public List<Order_list> getRevenueByMonth() {
         String sql = "SELECT YEAR(Date) AS Nam, MONTH(Date) AS Thang, "
               + "SUM(Total) AS DoanhThu "
               + "FROM Order_List "
               + "WHERE Status = 'Thành Công' "
               + "GROUP BY YEAR(Date), MONTH(Date) "
               + "ORDER BY Nam, Thang";
    return getRevenueData(sql, "month");
    }

    public List<Order_list> getRevenueByYear() {
        String sql = "SELECT YEAR(Date) AS Nam, SUM(Total) AS DoanhThu "
                + "FROM Order_List "
                + "WHERE Status IN ('Thành Công') "
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
                + "WHERE Status IN ('Thành Công') "
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
        String sql = "SELECT SUM(Total) FROM Order_List WHERE Status IN ('Thành Công')";
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
