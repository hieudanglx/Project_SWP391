/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
import model.EmailSenderStaff;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class AccountDao extends dao.DBContext {

    public Integer ValidateStaff_Admin(String username, String password) {

        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return null;
        }

        String query = "Select username, password, status from Staff where username = ? and password = ?";
        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashPassword(password));

            try ( ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt("status") ;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
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

    public Integer getStaffIdByUsername(String username) {
        String query = "SELECT staffID FROM Staff WHERE username = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);

            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("staffID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Trả về null nếu không tìm thấy
    }
    
    public Integer getAdminIdByUsername(String username) {
        String query = "SELECT staffID FROM Staff WHERE username = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, username);

            try ( ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("staffID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Trả về null nếu không tìm thấy
    }

    public AccountStaff getStaffByEmail(String email) {
        if (connection == null) {
            System.out.println("Lỗi: Kết nối cơ sở dữ liệu không tồn tại.");
            return null;
        }
        String sql = "SELECT * FROM Staff WHERE Email = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new AccountStaff(
                        rs.getInt("StaffID"),
                        rs.getString("Address"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Username"),
                        rs.getString("CCCD"),
                        rs.getString("Sex"),
                        rs.getString("dob"),
                        rs.getString("province_city"),
                        rs.getInt("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
        String query = "SELECT * FROM Staff Where IsDelete=0"; // Truy vấn lấy tất cả staff
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
                        rs.getString("CCCD"),
                        rs.getString("Sex"),
                        rs.getString("dob"),
                        rs.getString("province_city"),
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
                    return new AccountCustomer(
                            rs.getInt("CustomerID"),
                            rs.getString("username"),
                            rs.getString("fullName"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("address"),
                            rs.getString("phoneNumber"),
                            rs.getInt("Status"),
                            rs.getString("sex"),
                            rs.getString("dob"),
                            rs.getString("imgcustomer")
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
                        rs.getInt("CustomerID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("Status"),
                        rs.getString("sex"),
                        rs.getString("dob"),
                        rs.getString("imgcustomer")
                );

                list.add(accountCustomer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAccountCustomer(int customerID) {
        String[] queries = {
            "UPDATE Order_List SET CustomerID = 0 WHERE CustomerID = ?",
            "DELETE FROM Reply_Feedback WHERE CustomerID = ?",
            "DELETE FROM Feedback WHERE CustomerID = ?",
            "DELETE FROM Cart WHERE CustomerID = ?",
            "DELETE FROM Customer WHERE CustomerID = ?"
        };

        try {
            connection.setAutoCommit(false); // 🔴 Bắt đầu transaction

            for (String query : queries) {
                try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
                    pstmt.setInt(1, customerID);
                    pstmt.executeUpdate();
                }
            }

            connection.commit(); // ✅ Commit nếu không có lỗi
            System.out.println("🗑️ Xóa khách hàng thành công!");
            return true;

        } catch (SQLException e) {
            try {
                connection.rollback(); // 🔄 Hoàn tác nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        }
        return false;
    }

    public List<AccountCustomer> searchCustomerByUsername(String keyword) {
        List<AccountCustomer> customers = new ArrayList<>();
        String query = "SELECT customerID, username,fullName, email, address, phoneNumber, sex, dob, status, imgCustomer FROM Customer WHERE username LIKE ? OR fullname LIKE ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            String searchKey = "%" + keyword + "%"; // Tìm kiếm tương đối
            pstmt.setString(1, searchKey);
            pstmt.setString(2, searchKey);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                AccountCustomer customer = new AccountCustomer();
                customer.setCustomerID(rs.getInt("customerID"));
                customer.setUsername(rs.getString("username"));
                customer.setFullName(rs.getString("fullName"));
                customer.setEmail(rs.getString("email"));
                customer.setAddress(rs.getString("address"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setSex(rs.getString("sex"));
                customer.setDob(rs.getString("dob"));
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
    String query = "UPDATE [dbo].[Staff] SET IsDelete = 1 WHERE StaffID = ?";
    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setInt(1, staffID);
        int rowsDeleted = stmt.executeUpdate();
        return rowsDeleted > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    public boolean updateAccountStaff(AccountStaff staff) {
        String query = "UPDATE Staff SET address = ?, email = ?, password = ?, fullName = ?, phoneNumber = ?, username = ?, status = ? WHERE staffID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, staff.getAddress());
            ps.setString(2, staff.getEmail());
            ps.setString(3, hashPassword(staff.getPassword()));
            ps.setString(4, staff.getFullName());
            ps.setString(5, staff.getPhoneNumber());
            ps.setString(6, staff.getUsername());
            ps.setInt(7, staff.getStatus());
            ps.setInt(8, staff.getStaffID());

            int rowsUpdated = ps.executeUpdate();
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
                        rs.getString("CCCD"),
                        rs.getString("Sex"),
                        rs.getString("dob"),
                        rs.getString("province_city"),
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
        String sql = "SELECT * FROM staff WHERE staffID = ?";

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
                        rs.getString("CCCD"),
                        rs.getString("Sex"),
                        rs.getString("dob"),
                        rs.getString("province_city"),
                        rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return AccountStaff;
    }

    public void updateCustomerStatus(int customerID, int status) {
        String query = "UPDATE customer SET Status = ? WHERE customerID = ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, status);
            pstmt.setInt(2, customerID);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    // Chặn tài khoản khách hàng
//    public void blockCustomer(int customerID) {
//        updateCustomerStatus(customerID, 1); // 1 = Blocked
//    }
//
//    // Mở khóa tài khoản khách hàng
//    public void unblockCustomer(int customerID) {
//        updateCustomerStatus(customerID, 0); // 0 = Active
//    }
    public boolean isUsernameStaffExists(String username) {
    String sql = "SELECT COUNT(*) FROM Staff WHERE Username = ? AND isDelete = 0";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Kiểm tra email có tồn tại (chỉ kiểm tra tài khoản chưa bị xóa)
public boolean isEmailStaffExists(String email) {
    String sql = "SELECT COUNT(*) FROM Staff WHERE Email = ? AND isDelete = 0";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Kiểm tra số điện thoại có tồn tại (chỉ kiểm tra tài khoản chưa bị xóa)
public boolean isPhoneNumberStaffExists(String phoneNumber) {
    String sql = "SELECT COUNT(*) FROM Staff WHERE PhoneNumber = ? AND isDelete = 0";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, phoneNumber);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Kiểm tra CCCD có tồn tại (chỉ kiểm tra tài khoản chưa bị xóa)
public boolean isCCCDExists(String cccd) {
    String sql = "SELECT COUNT(*) FROM Staff WHERE CCCD = ? AND isDelete = 0";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, cccd);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

// Thêm nhân viên mới
public boolean addStaff(AccountStaff staff) {
    String sql = "INSERT INTO Staff (FullName, Username, Password, Email, PhoneNumber, "
               + "Address, CCCD, Province_City, DOB, Sex, Status, isDelete) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staff.getFullName());
        ps.setString(2, staff.getUsername());
        ps.setString(3, hashPassword(staff.getPassword()));
        ps.setString(4, staff.getEmail());
        ps.setString(5, staff.getPhoneNumber());
        ps.setString(6, staff.getAddress());
        ps.setString(7, staff.getCccd());
        ps.setString(8, staff.getProvince_city());
        ps.setDate(9, java.sql.Date.valueOf(staff.getDob()));
        ps.setString(10, staff.getSex());
        ps.setInt(11, staff.getStatus());
        ps.setBoolean(12, staff.isDelete());

        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public List<AccountStaff> searchStaffByFullName(String fullName) {
        List<AccountStaff> staffList = new ArrayList<>();
        String query = "SELECT StaffID, FullName, Email, PhoneNumber, Address, Username, Status FROM Staff WHERE FullName LIKE ?";

        try ( PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, "%" + fullName + "%"); // Tìm kiếm theo từ khóa

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                AccountStaff staff = new AccountStaff();
                staff.setStaffID(rs.getInt("StaffID"));
                staff.setFullName(rs.getString("FullName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhoneNumber(rs.getString("PhoneNumber"));
                staff.setAddress(rs.getString("Address"));
                staff.setUsername(rs.getString("Username"));
                staff.setStatus(rs.getInt("Status"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    // Phương thức cập nhật mật khẩu nhân viên
    public boolean updateStaffPassword(String email, String newPassword) {
        String query = "UPDATE Staff SET password = ? WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, hashPassword(newPassword));
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
        boolean isSent = EmailSenderStaff.sendEmail(email, subject, message);
        return isSent ? otp : null;
    }

    // Hàm tạo mã OTP 6 chữ số
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public AccountStaff getAccountStaffByEmail(String email) {
        String query = "SELECT * FROM Staff WHERE email = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
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
                        rs.getString("CCCD"),
                        rs.getString("Sex"),
                        rs.getString("dob"),
                        rs.getString("province_city"),
                        rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy nhân viên
    }

    public boolean updateAccountStaff_ForAdmin(AccountStaff staff) {
        String query = "UPDATE Staff SET address = ?, email = ?, password = ?, fullName = ?, phoneNumber = ?, "
                + "status = ?, province_city = ?, dob = ?, sex = ? WHERE staffID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, staff.getAddress());
            ps.setString(2, staff.getEmail());
            ps.setString(3, hashPassword(staff.getPassword()));
            ps.setString(4, staff.getFullName());
            ps.setString(5, staff.getPhoneNumber());
            ps.setInt(6, staff.getStatus());
            ps.setString(7, staff.getProvince_city());
            ps.setString(8, staff.getDob());
            ps.setString(9, staff.getSex());
            ps.setInt(10, staff.getStaffID());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        int customerID = 0;
        AccountDao accountDao = new AccountDao();
        // Gọi phương thức xóa
        boolean isDeleted = accountDao.deleteAccountCustomer(customerID);

        if (isDeleted) {
            System.out.println("🗑️ Xóa khách hàng thành công!");
        } else {
            System.out.println("❌ Xóa khách hàng thất bại!");
        }

        String password = "123";
        String hashedPassword = accountDao.hashPassword(password);
        System.out.println("MD5 Hash: " + hashedPassword);
    }

}
