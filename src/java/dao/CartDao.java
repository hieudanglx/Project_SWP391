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
/**
 *
 * @author CE180594_Phan Quốc Duy
 */
public class CartDao extends DBContext {

    public CartDao() {
    }

    public List<Product> getCartByCustomerID(int customerId) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, p.Color, c.Quantity,p.ImageURL,p.isDelete "
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
        String sql = "UPDATE Cart SET Quantity = Quantity " + type + " 1 WHERE CustomerID = ? AND ProductID = ?";
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

    public int getTotalItems(List<Product> list, int CustomerID) {
        int size = 0;
        if (list.isEmpty()) {
            list = getCartByCustomerID(CustomerID);
        }

        for (int i = 0; i < list.size(); i++) {
            size += list.get(i).getQuantityProduct();
        }
        return size;
    }

    public Boolean AddProductToCart(int customerID, int productID) {
        if (ProductExistsInCart(customerID, productID)) {
            return updateCartProduct(customerID, productID, "+");
        }
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

}
