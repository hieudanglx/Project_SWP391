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
import model.Order_Details;
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
        String query = "SELECT * FROM Order_List";

        try ( PreparedStatement pstmt = connection.prepareStatement(query);  ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Order_list order = new Order_list(
                        rs.getInt("OrderID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("StaffID"),
                        rs.getString("Address"),
                        rs.getDate("Date"), // 
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

    public boolean updateOrderStatus(int orderID, String newStatus,int StaffId) {
        String query = "UPDATE Order_List SET Status = ?,StaffID = ? WHERE OrderID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, StaffId);
            pstmt.setInt(3, orderID);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateOrderStatusC(int orderID, String newStatus) {
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
        String updateQuery = "UPDATE Product SET Quantity_Product = Quantity_Product + ?,Quantity_Sell=Quantity_Sell - ? WHERE ProductID = ?";

        try ( PreparedStatement pstmtSelect = connection.prepareStatement(selectQuery);  PreparedStatement pstmtUpdate = connection.prepareStatement(updateQuery)) {

            pstmtSelect.setInt(1, orderID);
            ResultSet rs = pstmtSelect.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");

                pstmtUpdate.setInt(1, quantity);
                pstmtUpdate.setInt(2, quantity);
                pstmtUpdate.setInt(3, productID);
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
        String query = "SELECT o.OrderID, o.Address, o.Date, o.Status, o.Total, o.PhoneNumber, "
                + "c.FullName , s.FullName, "
                + "od.Quantity, p.ProductName, p.Price, p.Color "
                + "FROM Order_List o "
                + "JOIN Customer c ON o.CustomerID = c.CustomerID "
                + "JOIN Order_Details od ON o.OrderID = od.OrderID "
                + "JOIN Product p ON od.ProductID = p.ProductID "
                + "JOIN Staff s ON o.StaffID = s.StaffID "
                + "WHERE o.OrderID = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
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
                + "ORDER BY Nam DESC, Thang DESC";
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

    public List<Integer> getAvailableYears() {
        List<Integer> years = new ArrayList<>();
        String sql = "SELECT DISTINCT YEAR(Date) AS year FROM Order_List ORDER BY year DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                years.add(rs.getInt(1));
            }

            // Debug: In ra danh sách năm lấy được
            System.out.println("Years retrieved: " + years);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return years;
    }

    
    public List<Order_Details> getOrderDetailsByOrderID(int orderID) {
        List<Order_Details> orderDetailsList = new ArrayList<>();
        String sql = "SELECT od.OrderDetailID, od.Quantity, od.ProductID, ol.OrderID, "
                + "p.ProductName, p.Price, p.ImageURL, ol.Date, ol.Status, "
                + "c.FullName, ol.Address, ol.PhoneNumber, ol.Total " // Thêm Total
                + "FROM Order_Details od "
                + "JOIN Order_List ol ON od.OrderID = ol.OrderID "
                + "JOIN Customer c ON ol.CustomerID = c.CustomerID "
                + "JOIN Product p ON od.ProductID = p.ProductID "
                + "WHERE ol.OrderID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order_Details orderDetail = new Order_Details(
                        rs.getInt("OrderDetailID"),
                        rs.getInt("Quantity"),
                        rs.getInt("ProductID"),
                        rs.getInt("OrderID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price"),
                        rs.getString("ImageURL"),
                        rs.getDate("Date"),
                        rs.getString("Status"),
                        rs.getString("FullName"),
                        rs.getString("Address"),
                        rs.getString("PhoneNumber"),
                        rs.getInt("Total") // Lấy thêm Total
                );
                orderDetailsList.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetailsList;
    }

    public List<Order_Details> getOrdersByCustomer(int customerID) {
        List<Order_Details> orderList = new ArrayList<>();
        String sql = "SELECT od.OrderDetailID, od.Quantity, od.ProductID, od.OrderID, "
                + "       p.ProductName, p.Price, p.ImageURL, o.Date, o.Status "
                + "FROM Order_Details od "
                + "JOIN Product p ON od.ProductID = p.ProductID "
                + "JOIN Order_List o ON od.OrderID = o.OrderID "
                + "WHERE o.CustomerID = ? "
                + "ORDER BY o.Date DESC";

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order_Details order = new Order_Details(
                        rs.getInt("OrderDetailID"),
                        rs.getInt("Quantity"),
                        rs.getInt("ProductID"),
                        rs.getInt("OrderID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price"),
                        rs.getString("ImageURL"),
                        rs.getDate("Date"),
                        rs.getString("Status")
                );
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public List<Order_Details> getOrdersByStatusCustomer(int customerID, String status) {
        List<Order_Details> orderList = new ArrayList<>();
        String sql = "SELECT od.OrderDetailID, od.Quantity, od.ProductID, od.OrderID, "
                + "       p.ProductName, p.Price, p.ImageURL, o.Date, o.Status "
                + "FROM Order_Details od "
                + "JOIN Product p ON od.ProductID = p.ProductID "
                + "JOIN Order_List o ON od.OrderID = o.OrderID "
                + "WHERE o.CustomerID = ? "
                + (status != null && !status.equals("Tất cả") ? "AND o.Status = ? " : "")
                + "ORDER BY o.Date DESC"; // Sắp xếp theo ngày gần nhất

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerID);
            if (status != null && !status.equals("Tất cả")) {
                stmt.setString(2, status);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order_Details order = new Order_Details(
                        rs.getInt("OrderDetailID"),
                        rs.getInt("Quantity"),
                        rs.getInt("ProductID"),
                        rs.getInt("OrderID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price"),
                        rs.getString("ImageURL"),
                        rs.getDate("Date"),
                        rs.getString("Status")
                );
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
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
    
    public List<Order_list> getOrdernew(){
    List<Order_list> order_list = new ArrayList<>();
    String sql = "SELECT TOP 10 c.FullName, ol.Date, ol.Address, p.ProductName, " +
                     "p.Price, ol.Status, od.Quantity, ol.Total " +
                     "FROM Order_List ol " +
                     "JOIN Order_Details od ON ol.OrderID = od.OrderID " +
                     "JOIN Product p ON od.ProductID = p.ProductID " +
                     "JOIN Customer c ON ol.CustomerID = c.CustomerID " +
                     "ORDER BY ol.Date DESC";
    
    try(PreparedStatement pstmt = connection.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()){
       while (rs.next()){
          Order_list order = new Order_list();
                order.setFullname(rs.getString("FullName"));
                order.setDate(rs.getDate("Date"));
                order.setAddress(rs.getString("Address"));
                order.setProductName(rs.getString("ProductName"));
                order.setPrice(rs.getDouble("Price"));
                order.setStatus(rs.getString("Status"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setTotal(rs.getDouble("Total"));
                order_list.add(order);
       }
    }catch(Exception e){
     e.printStackTrace();
    }
        return order_list;    
    }

//    public static void main(String[] args) {
//        OrderDAO orderDAO = new OrderDAO();
//        DecimalFormat df = new DecimalFormat("#,###.##");
//
//        List<Order_list> orderList = orderDAO.getAllOrders();
//
//        // Kiểm tra nếu danh sách rỗng
//        if (orderList == null || orderList.isEmpty()) {
//            System.out.println("Không có dữ liệu đơn hàng nào được tìm thấy!");
//        } else {
//            System.out.println("Danh sách đơn hàng:");
//            for (Order_list order : orderList) {
//                System.out.println("Order ID: " + order.getOrderID()
//                        + ", Date: " + order.getDate()
//                        + ", Total: " + order.getRevenue() + " VND");
//            }
//        }
//
//        System.out.println("Doanh thu theo tháng:");
//        for (Order_list order : orderDAO.getRevenueByMonth()) {
//            System.out.println("Năm: " + order.getYear() + ", Tháng: " + order.getPeriod()
//                    + ", Doanh thu: " + df.format(order.getRevenue()));
//        }
//
//        System.out.println("\nDoanh thu theo quý:");
//        for (Order_list order : orderDAO.getRevenueByQuarter()) {
//            System.out.println("Năm: " + order.getYear() + ", Quý: " + order.getPeriod()
//                    + ", Doanh thu: " + df.format(order.getRevenue()));
//        }
//
//        System.out.println("\nDoanh thu theo năm:");
//        for (Order_list order : orderDAO.getRevenueByYear()) {
//            System.out.println("Năm: " + order.getYear() + ", Doanh thu: " + df.format(order.getRevenue()));
//        }
//    }
    // Thêm đơn hàng vào bảng Order_list
    public int insertOrder(Order_list order) {
        int orderID = -1;
        String sql = "INSERT INTO Order_List (CustomerID, StaffID, Address, Date, Status, PhoneNumber, Total) "
                + "OUTPUT INSERTED.OrderID VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setInt(1, order.getCustomerID());
            ps.setInt(2, order.getStaffID());
            ps.setString(3, order.getAddress());
            ps.setDate(4, order.getDate());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPhoneNumber());
            ps.setDouble(7, order.getTotal());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderID;
    }

    // Thêm chi tiết đơn hàng vào bảng Order_Details
    public void insertOrderDetail(Order_Details orderDetail) {
        String sql = "INSERT INTO Order_Details (Quantity, ProductID, OrderID) VALUES ( ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setInt(1, orderDetail.getQuantity());
            ps.setInt(2, orderDetail.getProductID());
            ps.setInt(3, orderDetail.getOrderID());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProductQuantity(int orderID) {
        String selectQuery = "SELECT ProductID, Quantity FROM Order_Details WHERE OrderID = ?";
        String updateQuery = "UPDATE Product SET Quantity_Product = Quantity_Product - ?, Quantity_Sell = Quantity_Sell + ? WHERE ProductID = ?";

        try ( PreparedStatement pstmtSelect = connection.prepareStatement(selectQuery);  PreparedStatement pstmtUpdate = connection.prepareStatement(updateQuery)) {

            pstmtSelect.setInt(1, orderID);
            ResultSet rs = pstmtSelect.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");

                pstmtUpdate.setInt(1, quantity);
                pstmtUpdate.setInt(2, quantity);
                pstmtUpdate.setInt(3, productID);
                pstmtUpdate.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
