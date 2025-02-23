/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author CE180594_Phan Quốc Duy
 */
public class CartDao extends DBContext {

    public CartDao() {
    }

    public List<Product> getCartByCustomerID(int customerId) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.productName, p.Price, p.Color, c.quantity,p.ImageURL,p.isDelete "
                + "FROM Cart c JOIN Product p ON c.ProductID = p.ProductID "
                + "WHERE c.CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductID(rs.getString("ProductID"));
                    product.setProductName(rs.getString("productName"));
                    product.setPrice(rs.getInt("Price"));
                    product.setColor(rs.getString("Color"));
                    product.setQuantityProduct(rs.getInt("quantity"));
                    product.setImageURL(rs.getString("ImageURL"));
                    product.setIsDelete(rs.getInt("isDelete"));
                    productList.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public Boolean updateCartProduct(int customerID, String productID) {
        String sql = "UPDATE Cart SET Quantity = Quantity - 1 WHERE CustomerID = ? AND ProductID = ? AND Quantity > 0";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setString(2, productID);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Boolean removeProductFromCart(int customerID, String productID) {
        String sql = "DELETE FROM Cart WHERE CustomerID = ? AND ProductID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setString(2, productID);
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
