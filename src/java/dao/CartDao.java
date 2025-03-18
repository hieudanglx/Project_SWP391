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
        if (type.contains("+")) {
            sql += "AND Quantity < 5 AND (SELECT Quantity_Product FROM Product WHERE ProductID = ?) > (Quantity + 1)";
        }
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            if (type.contains("+")) {
                ps.setInt(3, productID);
            }
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.CartDao.updateCartProduct(): " + e.getMessage());
        }
        return false;
    }

    public int getTotalItems(List<Product> list, int CustomerID) throws SQLException {
        String sql = "SELECT COALESCE(SUM(c.Quantity), 0) AS Total_Items\n"
                + "FROM Cart c\n"
                + "WHERE c.CustomerID = ?;";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, CustomerID);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt("Total_Items");
                }
            } catch (Exception e) {
                System.out.println("dao.CartDao.getTotalItems(): " + e.getMessage());
            }
        }
        return 0;
    }

    public int getTotalCart(List<Product> list, int CustomerID) throws SQLException {
        String sql = "SELECT COALESCE(SUM(c.Quantity * p.Price), 0) AS Total_Cart_Value\n"
                + "FROM Cart c\n"
                + "JOIN Product p ON c.ProductID = p.ProductID\n"
                + "WHERE c.CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, CustomerID);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    return rs.getInt("Total_Cart_Value");
                }
            } catch (Exception e) {
                System.out.println("dao.CartDao.getTotalCart(): " + e.getMessage());
            }
        }
        return 0;
    }

    public Boolean AddProductToCart(int customerID, int productID) {
        String sql = "INSERT INTO Cart (CustomerID, ProductID, Quantity) VALUES (?, ?, 1)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.CartDao.AddProductToCart(): " + e.getMessage());
        }
        return false;
    }

    public Boolean ProductExistsInCart(int customerID, int productID) {
        String sql = "SELECT 1 FROM Cart WHERE CustomerID = ? AND ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            System.out.println("dao.CartDao.ProductExistsInCart(): " + e.getMessage());
        }
        return false;
    }

    public Boolean removeProductFromCart(int customerID, int productID) {
        String sql = "UPDATE Cart SET Quantity = 0 WHERE CustomerID = ? AND ProductID = ?";
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

}
