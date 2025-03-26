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

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
/**
 *
 * @author CE180594_Phan Quốc Duy
 */
public class CartDao extends DBContext {

    public CartDao() {
    }

    public List<Product> getCartByCustomerID(int customerId) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, p.Color, p.Ram, p.ROM"
                + ", p.Quantity_Product, c.Quantity, p.ImageURL, p.isDelete "
                + "FROM Cart c JOIN Product p ON c.ProductID = p.ProductID "
                + "WHERE c.CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setPrice(rs.getInt("Price"));
                    product.setColor(rs.getString("Color"));
                    product.setRam(rs.getString("Ram"));
                    product.setRom(rs.getString("ROM"));
                    product.setQuantitySell(rs.getInt("Quantity_Product"));
                    product.setQuantityProduct(rs.getInt("Quantity"));
                    product.setImageURL(rs.getString("ImageURL"));
                    product.setIsDelete(rs.getInt("isDelete"));

                    if (product.getIsDelete() != 1) {
                        productList.add(product);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Loi" + e.getMessage());
        }
        return productList;
    }

    public Boolean updateCartProduct(int customerID, int productID, String type) {
        String sql = "UPDATE Cart SET Quantity = Quantity " + type + " 1 "
                + "WHERE CustomerID = ? AND ProductID = ? ";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.CartDao.updateCartProduct(): " + e.getMessage());
        }
        return false;
    }

    public Boolean removeProductFromCart(int customerID, int productID) {
        String sql = "Delete Cart WHERE CustomerID = ? AND ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.CartDao.removeProductFromCart(): " + e.getMessage());
        }
        return false;
    }

    public void clearCart(int customerID) {
        String sql = "DELETE FROM Cart WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getProductQuantity(int productID) {
        String sql = "SELECT Quantity_Product FROM Product WHERE ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Quantity_Product");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy số lượng sản phẩm: " + e.getMessage());
        }
        return 0; // Mặc định là 0 nếu có lỗi
    }

    public boolean updateCartQuantity(int customerID, int productID, int newQuantity) {
        String sql = "UPDATE Cart SET Quantity = ? WHERE CustomerID = ? AND ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, customerID);
            ps.setInt(3, productID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật số lượng giỏ hàng: " + e.getMessage());
        }
        return false;
    }

    public boolean isProductInStock(int productId, int requestedQuantity) throws SQLException {
        String sql = "SELECT Quantity_Product FROM Product WHERE ProductID = ? where Quantity_Product >= ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, requestedQuantity);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        }
        return false;
    }

    public int productExistsInCart(int customerId, int productId) throws SQLException {
        String sql = "SELECT Quantity FROM Cart WHERE CustomerID = ? AND ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("Quantity") : 0;
            }
        } catch (Exception e){
            System.out.println("dao.CartDao.productExistsInCart()"+e.getMessage());
        }
        return 0;
    }

    public void addProductToCart(int customerId, int productId) throws SQLException {
        String sql = "INSERT INTO Cart (CustomerID, ProductID, Quantity) VALUES (?, ?, 1)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        }
    }

    public int getTotalItems(int customerId) throws SQLException {
        String sql = "SELECT SUM(Quantity) FROM Cart WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public long getTotalCartValue(int customerId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(CAST(c.Quantity AS BIGINT) * CAST(p.Price AS BIGINT)), 0) AS Total_Cart_Value\n"
                + "FROM Cart c\n"
                + "JOIN Product p ON c.ProductID = p.ProductID\n"
                + "WHERE c.CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getLong(1) : 0L;
            }
        }
    }
}
