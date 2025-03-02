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

    public boolean deleteProduct(String productID) {
        String query = "UPDATE [dbo].[Product] SET isDelete = 1 WHERE ProductID = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, productID);
            int rs = pstmt.executeUpdate();
            return rs > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

//    public boolean isProductIDExists(String productID) {
//    String query = "SELECT COUNT(*) FROM Product WHERE ProductID = ?";
//    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
//        pstmt.setString(1, productID);
//        try (ResultSet rs = pstmt.executeQuery()) {
//            return rs.next() && rs.getInt(1) > 0;
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
//    return false;
//}
    public boolean addProduct(Product product) {

//        if (isProductIDExists(product.getProductID())) {
//        System.out.println("Product already exists, cannot add.");
//        return false;
//    }
        String query = "INSERT INTO [dbo].[Product] "
                + "([ProductID], [ProductName], [Price], [CategoryID], [Brand], [Camera], [Ram], [Rom], "
                + "[Color], [Operating_System], [Size], [Refresh_rate], [Chip], [GPU], [Quantity_Sell], "
                + "[Quantity_Product], [ImageURL], [IsDelete]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); "
                + "INSERT INTO [dbo].[Import_Inventory] "
                + "([ProductID], [Import_price], [Date], [Import_quantity], [Supplier]) "
                + "VALUES (?, ?, GETDATE(), ?, ?)";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, product.getProductID());
            pstmt.setString(2, product.getProductName());
            pstmt.setInt(3, product.getPrice());
            pstmt.setInt(4, product.getCategoryID());
            pstmt.setString(5, product.getBrand());
            pstmt.setString(6, product.getCameraFront());
            pstmt.setString(7, product.getCameraBehind());
            pstmt.setString(8, product.getRam());
            pstmt.setString(9, product.getRamType());
            pstmt.setString(10, product.getSupportsUpgradingRAM());
            pstmt.setString(11, product.getRom());
            pstmt.setString(12, product.getSupportsUpgradingROM());
            pstmt.setString(13, product.getColor());
            pstmt.setString(14, product.getOperatingSystemName());
            pstmt.setString(15, product.getOperatingSystemVersion());
            pstmt.setString(16, product.getScreenSize());
            pstmt.setString(17, product.getRefreshRate());
            pstmt.setString(18, product.getChipName());
            pstmt.setString(19, product.getChipType());
            pstmt.setString(20, product.getGpuType());
            pstmt.setString(21, product.getGpuName());
            pstmt.setInt(22, product.getQuantitySell());
            pstmt.setInt(23, product.getQuantityProduct());
            pstmt.setString(24, product.getImageURL());
            pstmt.setInt(25, product.getIsDelete());

            // Set values for Import_Inventory table
            pstmt.setInt(26, product.getProductID()); // ProductID trong bảng Import_Inventory
            pstmt.setInt(27, 0); // Import_price (giả sử chưa có)          
            pstmt.setInt(28, 0); // Số lượng nhập hàng
            pstmt.setString(29, "Unknown"); // Supplier (nếu không có thì đặt giá trị mặc định)

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public Product getProductById(int productID) {
        String query = "SELECT * FROM Product WHERE ProductID = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, productID);
            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("Price"),
                            rs.getInt("CategoryID"),
                            rs.getString("Brand"),
                            rs.getString("Camera_Front"),
                            rs.getString("Camera_Behind"),
                            rs.getString("Ram"),
                            rs.getString("RAM_type"),
                            rs.getString("Supports_upgrading_RAM"),
                            rs.getString("Rom"),
                            rs.getString("Supports_upgrading_ROM"),
                            rs.getString("Color"),
                            rs.getString("Operating_System_name"),
                            rs.getString("Operating_system_version"),
                            rs.getString("Size_screeen"),
                            rs.getString("Refresh_rate"),
                            rs.getString("Screen_resolution"),
                            rs.getString("Chip_type"),
                            rs.getString("Chip_name"),
                            rs.getString("GPU_type"),
                            rs.getString("GPU_name"),
                            rs.getInt("Quantity_Sell"),
                            rs.getInt("Quantity_Product"),
                            rs.getString("ImageURL"),
                            rs.getInt("isDelete")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//    public boolean updateProduct(Product product) {
//        String query = "UPDATE Product SET "
//                + "productName = ?, "
//                + "price = ?, "
//                + "CategoryID = ?, "
//                + "brand = ?, "
//                + "camera = ?, "
//                + "ram = ?, "
//                + "rom = ?, "
//                + "color = ?, "
//                + "Operating_System = ?, "
//                + "size = ?, "
//                + "Refresh_rate = ?, "
//                + "chip = ?, "
//                + "gpu = ?, "
//                + "Quantity_Sell = ?, "
//                + "Quantity_Product = ?, "
//                + "imageURL = ? "
//                + "WHERE productID = ?";
//
//        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
//            pstmt.setString(1, product.getProductName());
//            pstmt.setInt(2, product.getPrice());
//            pstmt.setInt(3, product.getCategory());
//            pstmt.setString(4, product.getBrand());
//            pstmt.setString(5, product.getCamera());
//            pstmt.setString(6, product.getRam());
//            pstmt.setString(7, product.getRom());
//            pstmt.setString(8, product.getColor());
//            pstmt.setString(9, product.getOperatingSystem());
//            pstmt.setString(10, product.getSize());
//            pstmt.setString(11, product.getRefreshRate());
//            pstmt.setString(12, product.getChip());
//            pstmt.setString(13, product.getGpu());
//            pstmt.setInt(14, product.getQuantitySell());
//            pstmt.setInt(15, product.getQuantityProduct());
//            pstmt.setString(16, product.getImageURL());
//            pstmt.setString(17, product.getProductID()); // Điều kiện WHERE để xác định sản phẩm cần cập nhật
//
//            int affectedRows = pstmt.executeUpdate(); // Thực thi UPDATE
//            return affectedRows > 0; // Trả về true nếu cập nhật thành công
//        } catch (SQLException e) {
//            e.printStackTrace(); // Log lỗi SQL để debug
//        }
//        return false; // Trả về false nếu có lỗi xảy ra
//    }

    public List<Product> filterProducts(Product filter, String name, int minPrice, int maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Product WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (minPrice > 0) {
            sql.append(" AND Price >= ?");
            params.add(minPrice);
        }
        if (maxPrice > minPrice) {
            sql.append(" AND Price <= ?");
            params.add(maxPrice);
        }
        if (filter.getCategoryID() > 0) {
            sql.append(" AND CategoryID = ?");
            params.add(filter.getCategoryID());
        }
        addFilter(sql, params, "ProductName", name);
        addFilter(sql, params, "Brand", filter.getBrand());
        addFilter(sql, params, "Ram", filter.getRam());
        addFilter(sql, params, "Rom", filter.getRom());
        addFilter(sql, params, "Operating_System_name", filter.getOperatingSystemName());
        addFilter(sql, params, "Size_screeen", filter.getScreenSize());
        addFilter(sql, params, "Screen_resolution", filter.getScreenResolution());
        addFilter(sql, params, "Refresh_rate", filter.getRefreshRate());
        addFilter(sql, params, "Chip_name", filter.getChipName());

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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof String) {
                    ps.setString(i + 1, (String) params.get(i));
                } else if (params.get(i) instanceof Integer) {
                    ps.setInt(i + 1, (Integer) params.get(i));
                }
            }
            
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            rs.getInt("Price"),
                            rs.getInt("CategoryID"),
                            rs.getString("Brand"),
                            rs.getString("Camera_Front"),
                            rs.getString("Camera_Behind"),
                            rs.getString("Ram"),
                            rs.getString("RAM_type"),
                            rs.getString("Supports_upgrading_RAM"),
                            rs.getString("Rom"),
                            rs.getString("Supports_upgrading_ROM"),
                            rs.getString("Color"),
                            rs.getString("Operating_System_name"),
                            rs.getString("Operating_system_version"),
                            rs.getString("Size_screeen"),
                            rs.getString("Refresh_rate"),
                            rs.getString("Screen_resolution"),
                            rs.getString("Chip_type"),
                            rs.getString("Chip_name"),
                            rs.getString("GPU_type"),
                            rs.getString("GPU_name"),
                            rs.getInt("Quantity_Sell"),
                            rs.getInt("Quantity_Product"),
                            rs.getString("ImageURL"),
                            rs.getInt("isDelete")
                    );
                    if (p.getIsDelete() != 1) {
                        productList.add(p);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Loi1");
            System.out.println(e.getMessage());
        }
        return productList;
    }

    public Product getProductByProductID(int id) {
        String sql = "SELECT * FROM Product WHERE 1=1";
        List<Object> params = new ArrayList<>();
        params.add(id);
        return executeProductQuery(sql, params).get(0);
    }

    public List<Product> getProductByCategoryID(int id) {
        String sql = "SELECT * FROM Product WHERE CategoryID = ?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        return executeProductQuery(sql, params);
    }

    public List<Product> searchProductsByName(String name) {
        String sql = "SELECT * FROM Product WHERE ProductName LIKE ?";
        List<Object> params = new ArrayList<>();
        params.add("%" + name + "%");
        return executeProductQuery(sql, params);
    }

    public List<String> getAllCategory() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT Type FROM Category";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("Type"));
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<String> getBrandbyCategoryID(int id) throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT Brand FROM Product where CategoryID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("Brand"));
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

}
