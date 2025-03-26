/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author nguye
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.util.List;
import model.Customer;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO extends DBContext {

    // Hàm mã hóa mật khẩu MD5
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updateAvatar(int customerId, String avatarPath) {
        String sql = "UPDATE Customer SET imgcustomer = ? WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, avatarPath);
            ps.setInt(2, customerId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Avatar updated successfully for customer ID: " + customerId);
                return true;
            } else {
                System.out.println("No customer found with ID: " + customerId);
            }
        } catch (SQLException e) {
            System.out.println("Failed to update avatar: " + e.getMessage());
        }
        return false;
    }

    public boolean isPhoneExisted(String phone) {
        String sql = "SELECT * FROM Customer WHERE phoneNumber = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExisted(String email) {
        String sql = "SELECT * FROM Customer WHERE LOWER(email) = LOWER(?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isUsernameExisted(String username) {
        String sql = "SELECT * FROM Customer WHERE LOWER(username) = LOWER(?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Nếu có kết quả, username đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Integer ValidateStatusCustomer(String username, String password) {
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return null;
        }

        String sql = "SELECT status FROM Customer WHERE username = ? AND password = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            System.out.println("Đang kiểm tra tài khoản: " + username); // Log kiểm tra

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int status = rs.getInt("status");
                    System.out.println("Trạng thái tài khoản: " + status); // Log trạng thái
                    return status;
                } else {
                    System.out.println("Không tìm thấy tài khoản với username và password cung cấp.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer getCustomer(String username, String password) {
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return null;
        }
        String sql = "SELECT * FROM Customer WHERE Username = ? and Password = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer getCustomerByEmail(String email) {
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return null;
        }
        String sql = "SELECT * FROM Customer WHERE email = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePhoneNumber(String email, String newPhoneNumber) {
        String sql = "UPDATE Customer SET phoneNumber = ? WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newPhoneNumber);
            stmt.setString(2, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 hàng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi SQL ra console để debug
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Customer SET password = ? WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 hàng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi SQL ra console để debug
        }
        return false;
    }

    public void addCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (username, fullname, email, password, address, phoneNumber,sex , dob, Status, imgcustomer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPassword());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getPhoneNumber());
            ps.setString(7, customer.getSex());
            ps.setString(8, customer.getDob());
            ps.setString(9, customer.getStatus());
            ps.setString(10, customer.getImgCustomer());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET username=?,fullname=?, email=?, password=?, address=?, phoneNumber=?,sex=?, dob=?, Status=?, imgcustomer=? WHERE CustomerID=?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getPassword());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getPhoneNumber());
            ps.setString(7, customer.getSex());
            ps.setString(8, customer.getDob());
            ps.setString(9, customer.getStatus());
            ps.setString(10, customer.getImgCustomer());
            ps.setLong(11, customer.getCustomerID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCustomer(int customerID) {
        String sql = "DELETE FROM Customer WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public void add(Customer customer) throws SQLException {
        String sql = "INSERT INTO Customer (username, fullname, email, password, address, phoneNumber, sex, dob, Status, imgcustomer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) { // Sửa conn thành connection
            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getFullName());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getPassword());
            stmt.setString(5, customer.getAddress());
            stmt.setString(6, customer.getPhoneNumber());
            stmt.setString(7, customer.getSex());
            stmt.setString(8, customer.getDob());
            stmt.setString(9, "0");
            stmt.setString(10, customer.getImgCustomer());

            stmt.executeUpdate();
        }
    }

    public void saveResetToken(String email, String token) {
        String sql = "UPDATE Customer SET reset_token = ? WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.setString(2, email);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Customer getCustomerByToken(String token) {
        String sql = "SELECT * FROM Customer WHERE reset_token = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void removeResetToken(String email) {
        String sql = "UPDATE Customer SET reset_token = NULL WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCustomer(Customer customer, boolean updatePassword) {
        String sql;
        if (updatePassword) {
            sql = "UPDATE Customer SET username=?,fullname=?, email=?, password=?, address=?, phoneNumber=?,sex=?, dob=?, Status=?, imgcustomer=? WHERE CustomerID=?";

        } else {
            sql = "UPDATE Customer SET username=?,fullname=?, email=?, address=?, phoneNumber=?,sex=?, dob=?, Status=?, imgcustomer=? WHERE CustomerID=?";
        }

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getEmail());
            if (updatePassword) {
                ps.setString(4, customer.getPassword());
                ps.setString(5, customer.getAddress());
                ps.setString(6, customer.getPhoneNumber());
                ps.setString(7, customer.getSex());
                ps.setString(8, customer.getDob());
                ps.setString(9, customer.getStatus());
                ps.setString(10, customer.getImgCustomer());
                ps.setInt(11, customer.getCustomerID());
            } else {
                ps.setString(4, customer.getAddress());
                ps.setString(5, customer.getPhoneNumber());
                ps.setString(6, customer.getSex());
                ps.setString(7, customer.getDob());
                ps.setString(8, customer.getStatus());
                ps.setString(9, customer.getImgCustomer());
                ps.setInt(10, customer.getCustomerID());
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Customer getCustomerById(int customerId) {
        String sql = "SELECT * FROM Customer WHERE CustomerID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
