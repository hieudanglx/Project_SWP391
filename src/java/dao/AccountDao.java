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
import java.util.Random;
import model.AccountCustomer;
import model.AccountStaff;

import model.AccountCustomer;

import model.AccountStaff;
import model.EmailSender;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class AccountDao extends dao.DBContext {

    public boolean ValidateStaff_Admin(String username, String password) {

        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return false;
        }

        String query = "Select username, password, status from Staff where username = ? and password = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try ( ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt("status") == 0;
                }
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
        try ( PreparedStatement stmt = connection.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

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

    public AccountCustomer getCustomerID(int customerID) {
        String query = "Select * from Customer where CustomerID =  ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, customerID);
            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new AccountCustomer(rs.getInt("customerID"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("address"),
                            rs.getString("phoneNumber"),
                            rs.getInt("Status"),
                            rs.getString("imgCustomer")
                    );
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<AccountCustomer> getAllAccountCustomer() {
        List<AccountCustomer> list = new ArrayList<>();
        String query = "Select * from Customer";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                AccountCustomer accountCustomer = new AccountCustomer(
                        rs.getInt("customerID"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("Status"),
                        rs.getString("imgCustomer")
                );

                list.add(accountCustomer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAccountCustomer(int customerID) {

        String deleteCartQuery = "DELETE FROM Cart WHERE CustomerID = ?";
        String deleteCustomerQuery = "DELETE FROM Customer WHERE CustomerID = ?";

        try ( PreparedStatement pstmtCart = connection.prepareStatement(deleteCartQuery);  PreparedStatement pstmtCustomer = connection.prepareStatement(deleteCustomerQuery)) {

            // Xóa giỏ hàng trước
            pstmtCart.setInt(1, customerID);
            pstmtCart.executeUpdate();

            // Xóa tài khoản khách hàng
            pstmtCustomer.setInt(1, customerID);
            int rowAffected = pstmtCustomer.executeUpdate();

            return rowAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<AccountCustomer> searchCustomerByUsername(String username) {
        List<AccountCustomer> customers = new ArrayList<>();
        String query = "SELECT customerID, username, email, address, phoneNumber, status, imgCustomer FROM Customer WHERE username = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                AccountCustomer customer = new AccountCustomer();
                customer.setCustomerID(rs.getInt("customerID"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setStatus(rs.getInt("status"));
                customer.setImgCustomer(rs.getString("imgCustomer"));

                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public boolean deleteAccountStaff(int staffID) {
        String query = "DELETE FROM Staff WHERE staffID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
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
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
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
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
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

    public AccountStaff getStaffById(int id) {
        AccountStaff AccountStaff = null;
        String sql = "SELECT * FROM staff WHERE id = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                AccountStaff = new AccountStaff(
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
        return AccountStaff;
    }

    private void updateCustomerStatus(int customerID, int status) {
        String query = "UPDATE customer SET Status = ? WHERE customerID = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, status);
            pstmt.setInt(2, customerID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Chặn tài khoản khách hàng
    public void blockCustomer(int customerID) {
        updateCustomerStatus(customerID, 1); // 1 = Blocked
    }

    // Mở khóa tài khoản khách hàng
    public void unblockCustomer(int customerID) {
        updateCustomerStatus(customerID, 0); // 0 = Active
    }


    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE Username = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addStaff(String fullName, String username, String password, String email, String phoneNumber, String address, boolean status) {
        if (isUsernameExists(username)) {
            return false; // Không thêm nếu Username đã tồn tại
        }

        String sql = "INSERT INTO Staff (FullName, Username, Password, Email, PhoneNumber, Address, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, username);
            ps.setString(3, password); // Cần mã hóa nếu cần bảo mật
            ps.setString(4, email);
            ps.setString(5, phoneNumber);
            ps.setString(6, address);
            ps.setBoolean(7, status); // SQL Server hiểu 0 = Active, 1 = Inactive

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
    
    // Phương thức cập nhật mật khẩu nhân viên
    public boolean updateStaffPassword(String email, String newPassword) {
        String query = "UPDATE Staff SET password = ? WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Phương thức tạo và gửi mã OTP
    public String sendStaffOTP(String email) {
        String otp = generateOTP();
        String subject = "Xác nhận đổi mật khẩu";
        String message = "Mã OTP của bạn là: " + otp + " (Có hiệu lực trong 5 phút)";
        boolean isSent = EmailSender.sendEmail(email, subject, message);
        return isSent ? otp : null;
    }
    
    // Hàm tạo mã OTP 6 chữ số
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}


