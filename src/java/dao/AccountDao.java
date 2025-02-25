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
import model.AccountStaff;


/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class AccountDao extends DBContext{
      public boolean ValidateStaff_Admin(String username, String password) {
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return false;
        }

        String query = "Select username, password from Staff where username = ? and password = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try ( ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getFullname(String Username) {
        String query = "SELECT FullName FROM Staff WHERE Username = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, Username);
            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("FullName");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ""; // Trả về chuỗi rỗng thay vì null
    }
    public List<AccountStaff> getAllAccountStaff() {
        List<AccountStaff> list = new ArrayList<>();
        String query = "SELECT * FROM Staff"; // Truy vấn lấy tất cả staff

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                AccountStaff staff = new AccountStaff(
                    rs.getInt("StaffID"),
                    rs.getString("Address"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("FullName"),
                    rs.getString("PhoneNumber"),
                    rs.getString("Username"),
                    rs.getInt("Status")
                );
                list.add(staff);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
        
        
}
     public boolean deleteAccountStaff(int staffID) {
      String query = "DELETE FROM Staff WHERE staffID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, staffID); // Thiết lập giá trị cho tham số staffID
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0; // Trả về true nếu có ít nhất một hàng bị xóa
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
     public boolean updateAccountStaff(AccountStaff staff) {
    String query = "UPDATE Staff SET address = ?, email = ?, password = ?, fullName = ?, phoneNumber = ?, username = ?, status = ? WHERE staffID = ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setString(1, staff.getAddress());
        stmt.setString(2, staff.getEmail());
        stmt.setString(3, staff.getPassword());
        stmt.setString(4, staff.getFullName());
        stmt.setString(5, staff.getPhoneNumber());
        stmt.setString(6, staff.getUsername());
        stmt.setInt(7, staff.getStatus());
        stmt.setInt(8, staff.getStaffID());

        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0; // Trả về true nếu có ít nhất một hàng được cập nhật
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
     public AccountStaff getAccountStaffByID(int staffID) {
        String query = "SELECT * FROM Staff WHERE staffID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, staffID); // Thiết lập giá trị cho tham số staffID
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new AccountStaff(
                    rs.getInt("staffID"),
                    rs.getString("address"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("fullName"),
                    rs.getString("phoneNumber"),
                    rs.getString("username"),
                    rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy nhân viên
    }
    
}
