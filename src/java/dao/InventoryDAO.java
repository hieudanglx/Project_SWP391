/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Inventory;
import model.Product;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class InventoryDAO extends dao.DBContext {

    public List<Inventory> getAllInventories() {
        List<Inventory> inventories = new ArrayList<>();
        String query = "WITH LatestImport AS ( "
                + "    SELECT "
                + "        i.ProductID, "
                + "        i.Date, "
                + "        i.Import_price, "
                + "        i.Supplier, "
                + "        ROW_NUMBER() OVER (PARTITION BY i.ProductID ORDER BY i.Date DESC, i.Import_price DESC) AS rn "
                + "    FROM Import_Inventory i "
                + ") "
                + "SELECT "
                + "    p.ProductID, "
                + "    p.ProductName, "
                + "    li.Date AS Latest_Import_Date, "
                + "    li.Import_price, "
                + "    p.Price, "
                + "    p.Quantity_Product, "
                + "    li.Supplier "
                + "FROM Product p "
                + "LEFT JOIN LatestImport li "
                + "    ON p.ProductID = li.ProductID "
                + "    AND li.rn = 1 "
                + "WHERE p.IsDelete = 0;";  // Chỉ lấy sản phẩm chưa bị xóa

        try ( PreparedStatement stmt = connection.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Inventory inventory = new Inventory(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDate("Latest_Import_Date"),
                        rs.getInt("Import_price"),
                        rs.getInt("Price"),
                        rs.getInt("Quantity_Product"),
                        rs.getString("Supplier")
                );
                inventories.add(inventory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventories;
    }

    public Inventory getProductById(int productId) {
        String query = "SELECT ProductID, ProductName, Price FROM Product WHERE ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Inventory(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price") // Lấy giá bán từ DB
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // Trả về null nếu không tìm thấy sản phẩm
    }

    public List<Inventory> getInventoryListByCategory(String categoryType) {
        List<Inventory> inventoryList = new ArrayList<>();
        String query = "SELECT P.ProductID, P.ProductName, I.Date AS Latest_Import_Date, "
                + "I.Import_price AS Import_Price, P.Price AS Selling_Price, "
                + "P.Quantity_Product, I.Supplier "
                + "FROM Product P "
                + "LEFT JOIN Import_Inventory I ON I.Import_InventoryID = ("
                + "    SELECT TOP 1 I2.Import_InventoryID "
                + "    FROM Import_Inventory I2 "
                + "    WHERE I2.ProductID = P.ProductID "
                + "    ORDER BY I2.Date DESC, I2.Import_InventoryID DESC"
                + ") "
                + "LEFT JOIN Category C ON P.CategoryID = C.CategoryID "
                + "WHERE C.Type = ?";

        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, categoryType);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Inventory inventory = new Inventory(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getDate("Latest_Import_Date"), // Đúng tên cột
                        rs.getInt("Import_Price"), // Đúng tên cột
                        rs.getInt("Selling_Price"), // Đúng tên cột
                        rs.getInt("Quantity_Product"),
                        rs.getString("Supplier")
                );

                inventoryList.add(inventory);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inventoryList;
    }

    public boolean importProduct(int productID, int importQuantity, int importPrice, String supplier, Date importDate) {
        String sql = "INSERT INTO Import_Inventory (ProductID, Import_quantity, Import_price, Supplier, Date) VALUES (?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setInt(2, importQuantity);
            ps.setInt(3, importPrice);
            ps.setString(4, supplier);
            ps.setDate(5, importDate);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Inventory> searchInventory(String keyword) {
        List<Inventory> inventories = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, i.Date AS Latest_Import_Date, "
                + "p.Price, p.Quantity_Product "
                + "FROM Product p "
                + "LEFT JOIN Import_Inventory i "
                + "ON p.ProductID = i.ProductID "
                + "AND i.Date = (SELECT MAX(Date) FROM Import_Inventory WHERE ProductID = p.ProductID) "
                + "WHERE p.ProductName LIKE ?;";

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");  // Thêm ký tự % để tìm kiếm gần đúng

            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Inventory inventory = new Inventory(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getDate("Latest_Import_Date"),
                            rs.getInt("Price"),
                            rs.getInt("Quantity_Product")
                    );
                    inventories.add(inventory);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventories;
    }

    public int getSellingPrice(int productId) throws SQLException {
        String query = "SELECT Price FROM Product WHERE ProductID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("Price"); // Trả về giá bán sản phẩm
            }
        }
        return -1; // Trả về -1 nếu không tìm thấy sản phẩm
    }

    public List<Inventory> getImportHistory(Integer productID) {
        List<Inventory> importList = new ArrayList<>();
        String sql = "SELECT i.ProductID, p.ProductName, p.Brand, "
                + "i.Import_price, i.Import_quantity, i.Date AS Import_Date, i.Supplier "
                + "FROM Import_Inventory i "
                + "JOIN Product p ON i.ProductID = p.ProductID ";

        if (productID != null) {
            sql += "WHERE i.ProductID = ? ";
        }

        sql += "ORDER BY i.Date DESC, i.Import_InventoryID ASC";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            if (productID != null) {
                ps.setInt(1, productID);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Inventory inventory = new Inventory(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Brand"),
                        rs.getInt("Import_price"),
                        rs.getInt("Import_quantity"),
                        rs.getDate("Import_Date"),
                        rs.getString("Supplier")
                );
                importList.add(inventory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return importList;
    }

}

//    public static void main(String[] args) {
//
//       // try {
//            InventoryDAO inventoryDAO = new InventoryDAO();
//            List<Inventory> inventories = inventoryDAO.getAllInventories();
//
//            if (inventories.isEmpty()) {
//                System.out.println("⚠️ Không có dữ liệu tồn kho.");
//            } else {
//                System.out.println("📦 Danh sách tồn kho:");
//                for (Inventory inv : inventories) {
//                    System.out.println("ID: " + inv.getProductID()
//                            + " | Tên: " + inv.getProductName()
//                            + " | Ngày nhập: " + inv.getDATE()
//                            + " | Giá nhập: " + inv.getImport_price()
//                            + " | Giá bán: " + inv.getPrice()
//                            + " | Số lượng: " + inv.getQuantityProduct()
//                            + " | Nhà cung cấp: " + inv.getSupplier());
//                }
//            }
//
//            // 🔹 Kiểm tra tìm kiếm sản phẩm
//            String keyword = "iphone"; // Thay đổi từ khóa để kiểm tra
//            List<Inventory> resultList = inventoryDAO.searchInventory(keyword);
//
//            System.out.println("\n=== Kết quả tìm kiếm với từ khóa: '" + keyword + "' ===");
//            if (resultList.isEmpty()) {
//                System.out.println("❌ Không tìm thấy sản phẩm nào.");
//            } else {
//                System.out.println("✅ Tìm thấy " + resultList.size() + " sản phẩm:");
//                for (Inventory inventory : resultList) {
//                    System.out.println("- Product ID: " + inventory.getProductID()
//                            + " | Name: " + inventory.getProductName()
//                            + " | Supplier: " + inventory.getSupplier());
//                }
//            }
////
////            // 🔹 Nhập hàng mới
////            int productID = 1;  // ID sản phẩm cần nhập
////            int importQuantity = 50;  // Số lượng nhập vào
////            int importPrice = 150000;  // Giá nhập hàng
////            String supplier = "Tech Supplier Co.";  // Nhà cung cấp
////            Date importDate = new Date(System.currentTimeMillis()); // Ngày hiện tại
////
////            System.out.println("\n🔹 Đang nhập hàng vào kho...");
////            boolean success = inventoryDAO.importProduct(productID, importQuantity, importPrice, supplier, importDate);
////
////            if (success) {
////                System.out.println("✅ Nhập hàng thành công!");
////            } else {
////                System.out.println("❌ Nhập hàng thất bại.");
////            }
////
////            // 🔹 Kiểm tra lấy toàn bộ lịch sử nhập hàng
////            System.out.println("\n=== Lịch sử nhập hàng toàn bộ ===");
////            List<Inventory> allImportHistory = inventoryDAO.getAllImportHistory();
////            for (Inventory inv : allImportHistory) {
////                System.out.println(inv);
////            }
////
////            // 🔹 Kiểm tra lấy lịch sử nhập của một sản phẩm cụ thể (ví dụ: ProductID = 1)
////            System.out.println("\n=== Lịch sử nhập hàng của sản phẩm có ProductID = " + productID + " ===");
////            List<Inventory> productImportHistory = inventoryDAO.getImportHistoryByProductID(productID);
////            for (Inventory inv : productImportHistory) {
////                System.out.println(inv);
////            }
////
////        } catch (SQLException e) {
////            System.err.println("❌ Lỗi truy vấn SQL: " + e.getMessage());
////            e.printStackTrace();
////        }
////    }
//}
