package controller;

import dao.AccountDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AccountStaff;
import java.io.IOException;

@WebServlet(name = "EditAccount_Staff", urlPatterns = {"/EditAccount_Staff"})
public class EditAccount_Staff extends HttpServlet {

    private AccountDao accountDao;

    @Override
    public void init() {
        accountDao = new AccountDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffID = (Integer) session.getAttribute("staffID");

        if (staffID == null) {
            response.sendRedirect("LoginOfDashboard.jsp");
            return;
        }

        AccountStaff staff = accountDao.getAccountStaffByID(staffID);

        if (staff == null) {
            request.setAttribute("error", "Khong tim thay nhan vien");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        session.setAttribute("staff", staff); // Cập nhật session với thông tin mới
        request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffID = (Integer) session.getAttribute("staffId");

        if (staffID == null) {
            response.sendRedirect("LoginOfDashboard.jsp");
            return;
        }

        // Nhận dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String cccd = request.getParameter("cccd");

        // Kiểm tra dữ liệu hợp lệ
        if (fullName == null || email == null || phoneNumber == null || address == null || cccd == null
                || fullName.isEmpty() || email.isEmpty() || phoneNumber.isEmpty() || address.isEmpty() || cccd.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin nhân viên hiện tại
        AccountStaff existingStaff = (AccountStaff) session.getAttribute("staff");
        if (existingStaff == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Cập nhật thông tin
        existingStaff.setFullName(fullName);
        existingStaff.setEmail(email);
        existingStaff.setPhoneNumber(phoneNumber);
        existingStaff.setAddress(address);
        existingStaff.setCccd(cccd);

        // Gọi DAO để cập nhật
        boolean isUpdated = accountDao.updateAccountStaff(existingStaff);
        if (isUpdated) {
            session.setAttribute("staff", existingStaff); // Cập nhật session
            session.setAttribute("updateSuccess", "Profile updated successfully!");
            response.sendRedirect("viewProfileStaff.jsp"); // Quay lại trang hồ sơ
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
            request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Edit Account Staff Controller";
    }
}
