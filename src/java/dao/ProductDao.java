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
 * @author Dinh Van Do - CE182224
 */
public class ProductDao extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product";


        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getString("ProductID"),
                        rs.getString("productName"),
                        rs.getInt("Price"),
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
    
    public List<Product> filterProducts(Product filter, int minPrice, int maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Product WHERE 1=1");
        List<Object> params = new ArrayList<>();

//        if (minPrice > 0) {
//            sql.append(" AND Price >= ?");
//            params.add(minPrice);
//        }
//        if (maxPrice > minPrice) {
//            sql.append(" AND Price <= ?");
//            params.add(maxPrice);
//        }
//        if (filter.getCategoryID() > 0) {
//            sql.append(" AND CategoryID = ?");
//            params.add(filter.getCategoryID());
//        }

        addFilter(sql, params, "Brand", filter.getBrand());
        addFilter(sql, params, "Ram", filter.getRam());
        addFilter(sql, params, "Rom", filter.getRom());
        addFilter(sql, params, "Size", filter.getSize());
        addFilter(sql, params, "Refresh_rate", filter.getRefreshRate());
        addFilter(sql, params, "Operating_System", filter.getOperatingSystem());
        addFilter(sql, params, "Chip", filter.getChip());
        addFilter(sql, params, "GPU", filter.getGpu());

        return executeProductQuery(sql.toString(), params);
    }

    private void addFilter(StringBuilder sql, List<Object> params, String column, String value) {
        if (value != null && !value.isEmpty()) {
            sql.append(" AND ").append(column).append(" LIKE ?");
            params.add("%" + value + "%");
        }
    }

    private List<Product> executeProductQuery(String sql, List<Object> params) {
        List<Product> productList = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof String) {
                    ps.setString(i + 1, (String) params.get(i));
                } else if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                }
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    productList.add(new Product(
                        rs.getString("ProductID"),
                        rs.getString("productName"),
                        rs.getInt("Price"),
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
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println("Loi1");
            System.out.println("Dao.ProductDAO.executeProductQuery()");
        }
        return productList;
    }
    public void getAllCategory(){
        
    }
}
