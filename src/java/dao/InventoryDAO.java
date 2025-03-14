/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

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

    public List<Inventory> getAllInventorys() {
    List<Inventory> list = new ArrayList<>();
    String query = "SELECT P.ProductID, P.ProductName, I.Date, I.Import_price, "
                 + "P.Price, P.Quantity_Product, P.Quantity_Sell, I.Supplier "
                 + "FROM Product P "
                 + "LEFT JOIN Import_Inventory I ON P.ProductID = I.ProductID "
                 + "WHERE P.isDelete = 0"; // Chỉ lấy sản phẩm chưa bị xóa

    try (PreparedStatement stmt = connection.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            Inventory inventory = new Inventory(
                rs.getInt("ProductID"),
                rs.getString("ProductName"),
                rs.getDate("Date"),
                rs.getInt("Import_price"),
                rs.getInt("Price"),
                rs.getInt("Quantity_Product"),
                rs.getInt("Quantity_Sell"),
                rs.getString("Supplier")
            );
            list.add(inventory);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


    public List<Inventory> getInventoryListByCategory(String categoryType) {
        List<Inventory> inventoryList = new ArrayList<>();
        String query = "SELECT P.ProductID, P.ProductName, I.Date, I.Import_price, "
                + "P.Price, I.Import_quantity, P.Quantity_Product, P.Quantity_Sell, I.Supplier "
                + "FROM Product P "
                + "LEFT JOIN Import_Inventory I ON P.ProductID = I.ProductID "
                + "LEFT JOIN Category C ON P.CategoryID = C.CategoryID "
                + "WHERE C.Type = ?";

        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, categoryType);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Inventory inventory = new Inventory();
                inventory.setProductID(rs.getInt("ProductID"));
                inventory.setProductName(rs.getString("ProductName"));
                inventory.setDATE(rs.getDate("Date"));
                inventory.setImport_price(rs.getInt("Import_price"));
                inventory.setPrice(rs.getInt("Price"));
                inventory.setQuantityProduct(rs.getInt("Quantity_Product"));
                inventory.setQuantitySell(rs.getInt("Quantity_Sell"));
                inventory.setSupplier(rs.getString("Supplier"));

                inventoryList.add(inventory);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inventoryList;
    }

    public List<Inventory> searchInventory(String keyword) {
    List<Inventory> inventoryList = new ArrayList<>();
    String query = "SELECT P.ProductID, P.ProductName, I.Date, I.Import_price, " +
                   "P.Price, P.Quantity_Product, P.Quantity_Sell, I.Supplier " +
                   "FROM Product P " +
                   "LEFT JOIN Import_Inventory I ON P.ProductID = I.ProductID " +
                   "WHERE LOWER(P.ProductName) LIKE LOWER(?) " +
                   "   OR LOWER(I.Supplier) LIKE LOWER(?)";

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, "%" + keyword + "%");
        ps.setString(2, "%" + keyword + "%");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Inventory inventory = new Inventory(
                rs.getInt("ProductID"),
                rs.getString("ProductName"),
                rs.getDate("Date"),  // Có thể NULL
                rs.getInt("Import_price"),
                rs.getInt("Price"),
                rs.getInt("Quantity_Product"),
                rs.getInt("Quantity_Sell"),
                rs.getString("Supplier")
            );
            inventoryList.add(inventory);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return inventoryList;
}
    
    public static void main(String[] args) {
        InventoryDAO in = new InventoryDAO();
//        List<Inventory> list = in.getAllInventorys();
//
//        System.out.println("list inventory");
//        for (Inventory inventory : list) {
//            System.out.println(inventory.toString());
//        }
//
//        String categoryType = "Laptop";
//        List<Inventory> filteredInventory = in.getInventoryListByCategory(categoryType);
//        System.out.println("\n=== Inventory List for Category: " + categoryType + " ===");
//        if (filteredInventory.isEmpty()) {
//            System.out.println("No inventory found for category: " + categoryType);
//        } else {
//            for (Inventory inventory : filteredInventory) {
//                System.out.println(inventory);
//            }
//        }

        // Kiểm tra tìm kiếm sản phẩm
        String keyword = "iphone"; // Thay đổi từ khóa để kiểm tra

        List<Inventory> resultList = in.searchInventory(keyword);

        System.out.println("\n=== Kết quả tìm kiếm với từ khóa: '" + keyword + "' ===");
        if (resultList.isEmpty()) {
            System.out.println("❌ Không tìm thấy sản phẩm nào.");
        } else {
            System.out.println("✅ Tìm thấy " + resultList.size() + " sản phẩm:");
            for (Inventory inventory : resultList) {
                System.out.println("- Product ID: " + inventory.getProductID()
                        + " | Name: " + inventory.getProductName()
                        + " | Supplier: " + inventory.getSupplier());
            }
        }
    }

}
