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
        String query = "SELECT p.ProductID, p.ProductName, p.Price, "
                + "p.CategoryID, p.Brand, p.Camera_Behind, p.Camera_Front, p.Ram, p.RAM_type, "
                + "p.Supports_upgrading_RAM, p.Rom, p.Supports_upgrading_ROM, p.Color, "
                + "p.Operating_System_name, p.Operating_system_version, p.Size_screeen, "
                + "p.Refresh_rate, p.Screen_resolution, p.Chip_type, p.Chip_name, "
                + "p.GPU_type, p.GPU_name, p.Quantity_Sell, p.Quantity_Product, p.ImageURL, p.IsDelete, "
                + "COALESCE(ii.Import_price, 0) AS Import_price "
                + "FROM Product p "
                + "LEFT JOIN Import_Inventory ii ON p.ProductID = ii.ProductID";  // JOIN để lấy Import_price

        try ( PreparedStatement pstmt = connection.prepareStatement(query);  ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductForAdmin(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price"),
                        rs.getInt("CategoryID"),
                        rs.getString("Brand"),
                        rs.getString("Camera_Behind"),
                        rs.getString("Camera_Front"),
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
                        rs.getInt("IsDelete"),
                        rs.getInt("Import_price") // Sửa đúng kiểu dữ liệu
                ));
            }
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

    public boolean isProductExists(Product product) {
        String query = "SELECT COUNT(*) FROM Product WHERE "
                + "(LOWER(ProductName) = LOWER(?)) AND "
                + "(LOWER(Ram) = LOWER(?)) AND "
                + "(LOWER(Rom) = LOWER(?)) AND "
                + "(LOWER(Color) = LOWER(?)) AND "
                + "(IsDelete = 0)";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, product.getProductName().toLowerCase());
            pstmt.setString(2, product.getRam().toLowerCase());
            pstmt.setString(3, product.getRom().toLowerCase());
            pstmt.setString(4, product.getColor().toLowerCase());

            try ( ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean isLaptopExists(Product product) {
    String query = "SELECT COUNT(*) FROM Product WHERE "
            + "(LOWER(ProductName) = LOWER(?)) AND "
            + "(LOWER(Ram) = LOWER(?)) AND "
            + "(LOWER(Rom) = LOWER(?)) AND "
            + "(LOWER(Color) = LOWER(?)) AND "
            + "(LOWER(Chip_name) = LOWER(?)) AND "
            + "(LOWER(GPU_name) = LOWER(?)) AND "
            + "(IsDelete = 0)";

    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
        pstmt.setString(1, product.getProductName().toLowerCase());
        pstmt.setString(2, product.getRam().toLowerCase());
        pstmt.setString(3, product.getRom().toLowerCase());
        pstmt.setString(4, product.getColor().toLowerCase());
        pstmt.setString(5, product.getChipName().toLowerCase());
        pstmt.setString(6, product.getGpuName().toLowerCase());

        try (ResultSet rs = pstmt.executeQuery()) {
            return rs.next() && rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    public boolean addProduct(Product product) {
        String query = "DECLARE @InsertedProductID INT; "
                + "INSERT INTO [dbo].[Product] "
                + "([ProductName], [Price], [CategoryID], [Brand], [Camera_Front], [Camera_Behind], "
                + "[Ram], [RAM_type], [Supports_upgrading_RAM], [Rom], [Supports_upgrading_ROM], "
                + "[Color], [Operating_System_name], [Operating_system_version], [Size_screeen], "
                + "[Refresh_rate], [Screen_resolution], [Chip_type], [Chip_name], [GPU_type], [GPU_name], "
                + "[Quantity_Sell], [Quantity_Product], [ImageURL], [IsDelete]) "
                + "VALUES (?, ?, ?, ?, NULLIF(?, ''), NULLIF(?, ''), ?, NULLIF(?, ''), NULLIF(?, ''), ?, NULLIF(?, ''), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); "
                + "SET @InsertedProductID = SCOPE_IDENTITY(); "
                + "INSERT INTO [dbo].[Import_Inventory] "
                + "([ProductID], [Import_price], [Date], [Import_quantity], [Supplier]) "
                + "VALUES (@InsertedProductID, ?, GETDATE(), ?, ?);";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            // Set values for Product table
            pstmt.setString(1, product.getProductName());
            pstmt.setInt(2, product.getPrice());
            pstmt.setInt(3, product.getCategoryID());
            pstmt.setString(4, product.getBrand());
            pstmt.setString(5, product.getCameraFront());
            pstmt.setString(6, product.getCameraBehind());
            pstmt.setString(7, product.getRam());
            pstmt.setString(8, product.getRamType());
            pstmt.setString(9, product.getSupportsUpgradingRAM());
            pstmt.setString(10, product.getRom());
            pstmt.setString(11, product.getSupportsUpgradingROM());
            pstmt.setString(12, product.getColor());
            pstmt.setString(13, product.getOperatingSystemName());
            pstmt.setString(14, product.getOperatingSystemVersion());
            pstmt.setString(15, product.getScreenSize());
            pstmt.setString(16, product.getRefreshRate());
            pstmt.setString(17, product.getScreenResolution());
            pstmt.setString(18, product.getChipType());
            pstmt.setString(19, product.getChipName());
            pstmt.setString(20, product.getGpuType());
            pstmt.setString(21, product.getGpuName());
            pstmt.setInt(22, product.getQuantitySell());
            pstmt.setInt(23, product.getQuantityProduct());
            pstmt.setString(24, product.getImageURL());
            pstmt.setInt(25, product.getIsDelete());

            // Set values for Import_Inventory table
            pstmt.setInt(26, 0); // Giá nhập hàng (giả sử mặc định 0)
            pstmt.setInt(27, 0); // Số lượng nhập hàng (giả sử mặc định 0)
            pstmt.setString(28, "Unknown"); // Nhà cung cấp mặc định

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int productID) {
    String query = "SELECT * FROM Product WHERE ProductID = ?";

    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
        pstmt.setInt(1, productID);
        try (ResultSet rs = pstmt.executeQuery()) {
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
                        rs.getString("Size_screeen"), // Sửa lỗi chính tả
                        rs.getString("Refresh_rate"),
                        rs.getString("Screen_resolution"),
                        rs.getString("Chip_type"),
                        rs.getString("Chip_name"),
                        rs.getString("GPU_type"),
                        rs.getString("GPU_name"),
                        rs.getInt("Quantity_Sell"),
                        rs.getInt("Quantity_Product"),
                        rs.getString("ImageURL"),
                        rs.getInt("IsDelete") // Đổi đúng tên cột
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}


    public boolean updateProduct(Product product) {
    String query = "UPDATE Product SET "
            + "ProductName = ?, "
            + "Price = ?, "
            + "CategoryID = ?, "
            + "Brand = ?, "
            + "Camera_Front = ?, "
            + "Camera_Behind = ?, "
            + "Ram = ?, "
            + "RAM_type = ?, "
            + "Supports_upgrading_RAM = ?, "
            + "Rom = ?, "
            + "Supports_upgrading_ROM = ?, "
            + "Color = ?, "
            + "Operating_System_name = ?, "
            + "Operating_system_version = ?, "
            + "Size_screeen = ?, "
            + "Refresh_rate = ?, "
            + "Screen_resolution = ?, "
            + "Chip_type = ?, "
            + "Chip_name = ?, "
            + "GPU_type = ?, "
            + "GPU_name = ?, "
            + "Quantity_Sell = ?, "
            + "Quantity_Product = ?, "
            + "ImageURL = ?, "
            + "IsDelete = ? "
            + "WHERE productID = ?";

    try (PreparedStatement pstmt = connection.prepareStatement(query)) {
        pstmt.setString(1, product.getProductName());
        pstmt.setInt(2, product.getPrice());
        pstmt.setInt(3, product.getCategoryID());
        pstmt.setString(4, product.getBrand());
        pstmt.setString(5, isEmpty(product.getCameraFront()) ? null : product.getCameraFront());
        pstmt.setString(6, isEmpty(product.getCameraBehind()) ? null : product.getCameraBehind());
        pstmt.setString(7, product.getRam());
        pstmt.setString(8, isEmpty(product.getRamType()) ? null : product.getRamType());
        pstmt.setString(9, isEmpty(product.getSupportsUpgradingRAM()) ? null : product.getSupportsUpgradingRAM());
        pstmt.setString(10, product.getRom());
        pstmt.setString(11, isEmpty(product.getSupportsUpgradingROM()) ? null : product.getSupportsUpgradingROM());
        pstmt.setString(12, product.getColor());
        pstmt.setString(13, product.getOperatingSystemName());
        pstmt.setString(14, product.getOperatingSystemVersion());
        pstmt.setString(15, product.getScreenSize());
        pstmt.setString(16, product.getRefreshRate());
        pstmt.setString(17, product.getScreenResolution());
        pstmt.setString(18, product.getChipType());
        pstmt.setString(19, product.getChipName());
        pstmt.setString(20, product.getGpuType());
        pstmt.setString(21, product.getGpuName());
        pstmt.setInt(22, product.getQuantitySell());
        pstmt.setInt(23, product.getQuantityProduct());
        pstmt.setString(24, product.getImageURL());
        pstmt.setInt(25, product.getIsDelete());
        pstmt.setInt(26, product.getProductID());

        int affectedRows = pstmt.executeUpdate();
        return affectedRows > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (NumberFormatException e) {
        System.err.println("Invalid number format: " + e.getMessage());
    }
    return false;
}
    // Hàm kiểm tra chuỗi rỗng hoặc null
private boolean isEmpty(String str) {
    return str == null || str.trim().isEmpty();
}

    
    
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
