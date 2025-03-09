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
 /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet logoutOfCustomerController</title>");
            out.println("</head>");
            out.println("<body>");            
            out.println("</body>");
            out.println("</html>");
        }
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "View Profile Staff Controller";
    }
}
