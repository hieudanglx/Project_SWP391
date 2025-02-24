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
import model.Product;
import model.ProductForAdmin;

/**
 *
 * @author Dinh Van Do - CE182224
 */
public class ProductDao extends DBContext {

    public List<ProductForAdmin> getAllProductsForAdmin() {
        List<ProductForAdmin> list = new ArrayList<>();
        String query = "SELECT \n"
                + "    p.ProductID, \n"
                + "    p.productName, \n"
                + "    p.price , \n"
                + "    ii.Import_Price, \n"
                + "    p.CategoryID, \n"
                + "    p.brand , \n"
                + "    p.camera, \n"
                + "    p.ram , \n"
                + "    p.rom , \n"
                + "    p.color, \n"
                + "    p.Operating_System , \n"
                + "    p.size , \n"
                + "    p.Refresh_rate , \n"
                + "    p.chip , \n"
                + "    p.gpu , \n"
                + "    p.Quantity_Sell, \n"
                + "    p.Quantity_Product , \n"
                + "    p.imageURL , \n"
                + "    p.isDelete \n"
                + "FROM Product p\n"
                + "JOIN Import_Inventory ii ON p.ProductID = ii.ProductID;";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductForAdmin product = new ProductForAdmin(
                        rs.getString("ProductID"),
                        rs.getString("productName"),
                        rs.getInt("Price"),
                        rs.getInt("Import_Price"),
                        rs.getInt("categoryID"),
                        rs.getString("Brand"),
                        rs.getString("Camera"),
                        rs.getString("Ram"),
                        rs.getString("Rom"),
                        rs.getString("Color"),
                        rs.getString("Operating_System"),
                        rs.getString("Size"),
                        rs.getString("Refresh_rate"),
                        rs.getString("Chip"),
                        rs.getString("GPU"),
                        rs.getInt("Quantity_Sell"),
                        rs.getInt("Quantity_Product"),
                        rs.getString("ImageURL"),
                        rs.getInt("isDelete")
                );
                list.add(product);
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO [dbo].[Product] "
            + "([ProductID], [ProductName], [Price], [CategoryID], [Brand], [Camera], [Ram], [Rom], "
            + "[Color], [Operating_System], [Size], [Refresh_rate], [Chip], [GPU], [Quantity_Sell], "
            + "[Quantity_Product], [ImageURL], [IsDelete]) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); "
            + "INSERT INTO [dbo].[Import_Inventory] "
            + "([ProductID], [Import_price], [Date], [Import_quantity], [Supplier]) "
            + "VALUES (?, ?, GETDATE(), ?, ?)";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, product.getProductID());
            pstmt.setString(2, product.getProductName());
            pstmt.setInt(3, product.getPrice());
            pstmt.setInt(4, product.getCategory());
            pstmt.setString(5, product.getBrand());
            pstmt.setString(6, product.getCamera());
            pstmt.setString(7, product.getRam());
            pstmt.setString(8, product.getRom());
            pstmt.setString(9, product.getColor());
            pstmt.setString(10, product.getOperatingSystem());
            pstmt.setString(11, product.getSize());
            pstmt.setString(12, product.getRefreshRate());
            pstmt.setString(13, product.getChip());
            pstmt.setString(14, product.getGpu());
            pstmt.setInt(15, product.getQuantitySell());
            pstmt.setInt(16, product.getQuantityProduct());
            pstmt.setString(17, product.getImageURL());
            pstmt.setInt(18, product.getIsDelete());

            // Set values for Import_Inventory table
            pstmt.setString(19, product.getProductID()); // ProductID trong bảng Import_Inventory
            pstmt.setInt(20, 0); // Import_price (giả sử chưa có)          
            pstmt.setInt(21, 0); // Số lượng nhập hàng
            pstmt.setString(22, "Unknown"); // Supplier (nếu không có thì đặt giá trị mặc định)

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
