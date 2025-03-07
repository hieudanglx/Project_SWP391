/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.jws.WebService;
import model.AccountStaff;
import org.apache.catalina.ha.ClusterSession;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
@WebServlet(name = "viewProfileStaff", urlPatterns = {"/viewProfileStaff"})
public class viewProfileStaffController extends HttpServlet {

    private AccountDao accountDao;

    public void init() {
        accountDao = new AccountDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session
        HttpSession session = request.getSession();

        // Kiểm tra nếu chưa có nhân viên đăng nhập thì chuyển hướng về trang đăng nhập
        Integer staffId = (Integer) session.getAttribute("staffId");

        if (staffId == null) {
            response.sendRedirect("LoginOfDashboard.jsp");
            return;
        }

        // Lấy thông tin nhân viên từ database
        AccountStaff staff = accountDao.getStaffById(staffId);

        if (staff != null) {
            session.setAttribute("staff", staff);
        }
        System.out.println("day la du lieu staff: "+staff.getFullName()+ staff.getStaffID()+":CMND-"+staff.getCccd());
        // Chuyển hướng đến trang hồ sơ nhân viên
        request.getRequestDispatcher("viewProfileStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDao accountDao = new AccountDao();
        HttpSession session = request.getSession();

        try {
            // Lấy staffID từ request
            int staffId = Integer.parseInt(request.getParameter("id"));

            // Tìm kiếm nhân viên theo ID
            AccountStaff accountStaff = accountDao.getStaffById(staffId);

            if (accountStaff != null) {
                // Lưu thông tin nhân viên vào session
                session.setAttribute("staffID", accountStaff.getStaffID());
                session.setAttribute("username", accountStaff.getUsername());
                session.setAttribute("fullName", accountStaff.getFullName());
                session.setAttribute("email", accountStaff.getEmail());
                session.setAttribute("phoneNumber", accountStaff.getPhoneNumber());
                session.setAttribute("address", accountStaff.getAddress());
                session.setAttribute("cccd", accountStaff.getCccd());
                // Chuyển hướng đến trang hồ sơ nhân viên
                response.sendRedirect("viewProfileStaff.jsp");
            } else {
                session.setAttribute("error", "Không tìm thấy nhân viên!");
                response.sendRedirect("LoginOfDashboard.jsp");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID phải là số nguyên!");
            response.sendRedirect("LoginOfDashboard.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "View Profile Staff Controller";
    }
}
