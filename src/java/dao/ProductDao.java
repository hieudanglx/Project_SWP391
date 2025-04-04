/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Product;
import model.ProductForAdmin;

/**
 *
 * @author Dinh Van Do - CE182224
 */
public class ProductDao extends DBContext {

    public List<Product> getAllProductsForAdmin() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product ";
        try ( PreparedStatement pstmt = connection.prepareStatement(query);  ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Product(
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
                        rs.getInt("IsDelete")
                ));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Map<Integer, String> getProductNames() {
        Map<Integer, String> productNames = new HashMap<>();
        String sql = "SELECT productID, productName FROM Product"; // Đúng cột productName
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("productID");
                String name = rs.getString("productName"); // Đúng cột productName
                productNames.put(id, name);
            }
            System.out.println("Product Names: " + productNames); // Debug
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productNames;
    }

    public boolean deleteProduct(String productID) {
        String updateProductQuery = "UPDATE [dbo].[Product] SET isDelete = 1 WHERE ProductID = ?";
        String deleteInventoryQuery = "DELETE FROM [dbo].[Import_Inventory] WHERE ProductID = ?";

        try ( PreparedStatement pstmt1 = connection.prepareStatement(updateProductQuery);  PreparedStatement pstmt2 = connection.prepareStatement(deleteInventoryQuery)) {

            // Cập nhật bảng Product
            pstmt1.setString(1, productID);
            int updateResult = pstmt1.executeUpdate();

            // Xóa khỏi bảng Import_Inventory
            pstmt2.setString(1, productID);
            int deleteResult = pstmt2.executeUpdate();

            return updateResult > 0 && deleteResult >= 0; // Đảm bảo cập nhật thành công và xóa (nếu có)

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

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, product.getProductName().toLowerCase());
            pstmt.setString(2, product.getRam().toLowerCase());
            pstmt.setString(3, product.getRom().toLowerCase());
            pstmt.setString(4, product.getColor().toLowerCase());
            pstmt.setString(5, product.getChipName().toLowerCase());
            pstmt.setString(6, product.getGpuName().toLowerCase());

            try ( ResultSet rs = pstmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addProduct(Product product) {
        String query = "INSERT INTO [dbo].[Product] "
                + "([ProductName], [Price], [CategoryID], [Brand], [Camera_Front], [Camera_Behind], "
                + "[Ram], [RAM_type], [Supports_upgrading_RAM], [Rom], [Supports_upgrading_ROM], "
                + "[Color], [Operating_System_name], [Operating_system_version], [Size_screeen], "
                + "[Refresh_rate], [Screen_resolution], [Chip_type], [Chip_name], [GPU_type], [GPU_name], "
                + "[Quantity_Sell], [Quantity_Product], [ImageURL], [IsDelete]) "
                + "VALUES (?, ?, ?, ?, NULLIF(?, ''), NULLIF(?, ''), ?, NULLIF(?, ''), NULLIF(?, ''), ?, NULLIF(?, ''), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

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

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
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
        }
        return false;
    }

// Hàm kiểm tra chuỗi rỗng hoặc null
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    public List<Product> filterProducts(Product filter, int minPrice, int maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Product WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (maxPrice != minPrice) {
            sql.append("AND Price between ? and ?");
            params.add(minPrice);
            params.add(maxPrice);
        }
        if (filter.getCategoryID() > 0) {
            sql.append(" AND CategoryID = ?");
            params.add(filter.getCategoryID());
        }
        addFilter(sql, params, "ProductName", filter.getProductName());
        addFilter(sql, params, "Brand", filter.getBrand());
        addFilter(sql, params, "Ram", filter.getRam());
        addFilter(sql, params, "Rom", filter.getRom());
        addFilter(sql, params, "Operating_System_name", filter.getOperatingSystemName());
        addFilter(sql, params, "Size_screeen", filter.getScreenSize());
        addFilter(sql, params, "Screen_resolution", filter.getScreenResolution());
        addFilter(sql, params, "Refresh_rate", filter.getRefreshRate());
        addFilter(sql, params, "Chip_type", filter.getChipType());
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

    public List<Product> getTopProductByCategoryID(int id) {
        String sql = "SELECT TOP 8 * FROM Product where CategoryID = ? ORDER BY Quantity_Sell DESC;";
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

    public List<Product> searchProductsByName(String name, int CategoryID) {
        String sql = "SELECT * FROM Product WHERE ProductName LIKE ? and CategoryID = ?";
        List<Object> params = new ArrayList<>();
        params.add("%" + name + "%");
        params.add(CategoryID);
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

    public List<String> getChipType() throws SQLException {
        List<String> list = new ArrayList<>();
        String sql = "Select distinct Chip_type from Product where CategoryID = 1";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("Chip_type"));
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public ArrayList<List<String>> getChipByChipType() throws SQLException {
        ArrayList<List<String>> list = new ArrayList<>();
        List<String> ChipType = getChipType();
        String sql = "SELECT DISTINCT \n"
                + "    CASE \n"
                + "        WHEN CHARINDEX(' ', Chip_name) > 0 THEN \n"
                + "            LEFT(Chip_name, \n"
                + "                 CASE \n"
                + "                     WHEN CHARINDEX(' ', Chip_name, CHARINDEX(' ', Chip_name) + 1) > 0 \n"
                + "                     THEN CHARINDEX(' ', Chip_name, CHARINDEX(' ', Chip_name) + 1) - 1\n"
                + "                     ELSE CHARINDEX(' ', Chip_name) - 1\n"
                + "                 END)\n"
                + "        ELSE Chip_name\n"
                + "    END AS Chip_Series\n"
                + "FROM Product\n"
                + "WHERE Chip_type LIKE ? AND CategoryID = 1;";
        for (int i = 0; i < ChipType.size(); i++) {
            String type = ChipType.get(i);
            List<String> chip = new ArrayList<>(); // Move this inside the loop

            try ( PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, "%" + type + "%");
                try ( ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        chip.add(rs.getString("Chip_Series"));
                    }
                }
            } catch (Exception e) {
                System.out.println("Product DAO: " + e.getMessage());
            }
            list.add(chip);
        }
        return list;
    }

    public List<Product> getTopSellingProducts(int categoryId) {
        String sql = "SELECT TOP 10 P.ProductID, P.ProductName, P.Color, P.Rom, P.Price, P.Quantity_Sell AS TotalSold "
                + "FROM Product P "
                + "WHERE P.CategoryID = ? "
                + "ORDER BY P.Quantity_Sell DESC";

        List<Product> products = new ArrayList<>();
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId); // Gán giá trị cho tham số ?

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Color"),
                        rs.getString("Rom"),
                        rs.getInt("Price"),
                        rs.getInt("TotalSold")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getTotalProduct() {
        String sql = "SELECT COUNT(*) AS totalProduct FROM Product";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                int totalProduct = rs.getInt("totalProduct"); // Sửa thành "totalProduct"
                System.out.println("Tổng số sản phẩm: " + totalProduct);
                return totalProduct; // Trả về số lượng sản phẩm
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi
    }

    public int getTotalPendingOrder() {
        String sql = "SELECT COUNT(*) AS totalOrderSuccessful FROM Order_List WHERE Status = 'Thành công'";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {
          if(rs.next()){
            return  rs.getInt("totalOrderSuccessful");
          }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getTotalOrderDelivery() {
        String sql = "SELECT COUNT(*) AS TotalOrderDelivery FROM Order_List WHERE Status = 'Giao Hàng'";
        try ( PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {
          if(rs.next()){
            return  rs.getInt("TotalOrderDelivery");
          }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        ProductDao pd = new ProductDao();
        List<Product> products = pd.getTopSellingProducts(1); // Thay 1 bằng CategoryID mong muốn

        System.out.println("Top 10 sản phẩm bán chạy nhất:");
        for (Product product : products) {
            System.out.println("ProductID: " + product.getProductID() + ", Name: " + product.getProductName()
                    + ", Color: " + product.getColor() + ", ROM: " + product.getRom() + ", Sold: " + product.getQuantitySell());
        }
    }
}
