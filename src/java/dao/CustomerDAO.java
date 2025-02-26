/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author nguye
 */
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.util.List;
import model.Customer;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO extends DBContext {

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

    public boolean validateCustomer(String username, String password) {
        String sql = "SELECT * FROM Customer WHERE username = ? AND password = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("imgcustomer")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
        String sql = "INSERT INTO Customer (username, email, password, address, phoneNumber, Status, imgcustomer) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getPhoneNumber());
            ps.setString(6, customer.getStatus());
            ps.setString(7, customer.getImgCustomer());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET username=?, email=?, password=?, address=?, phoneNumber=?, Status=?, imgcustomer=? WHERE CustomerID=?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getPhoneNumber());
            ps.setString(6, customer.getStatus());
            ps.setString(7, customer.getImgCustomer());
            ps.setLong(8, customer.getId());
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
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("imgcustomer")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public void add(Customer customer) throws SQLException {
        String sql = "INSERT INTO Customer (username, email, password, address, phoneNumber) VALUES (?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) { // Sửa conn thành connection
            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPassword());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getPhoneNumber());

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
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("Status"),
                        rs.getString("imgcustomer"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
