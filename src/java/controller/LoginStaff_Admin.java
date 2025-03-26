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

/**
 *
 * @author Tran Phong Hai - CE180803
 */
@WebServlet(name = "LoginStaff_Admin", urlPatterns = {"/LoginStaff_Admin"})
public class LoginStaff_Admin extends HttpServlet {

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
            out.println("<title>Servlet LoginStaff_Admin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginStaff_Admin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
        response.setContentType("text/html;charset=UTF-8");

        AccountDao accountDAO = new AccountDao();
        String username = request.getParameter("Username").trim();
        String password = request.getParameter("Password").trim();

//        if (username.isEmpty() || password.isEmpty()) {
//            request.setAttribute("errorMessage", "Tên người dùng và mật khẩu không được để trống!");
//            request.getRequestDispatcher("LoginOfDashboard.jsp").forward(request, response);
//            return;
//        }

        try {
            Integer status = accountDAO.ValidateStaff_Admin(username, password); // Đổi tên cho rõ ràng

            if (status != null) {
                if (status == 0) { // Tài khoản hoạt động
                    HttpSession session = request.getSession();
                    session.setAttribute("Username", username);
                    session.setAttribute("fullname", accountDAO.getFullname(username));

                    if (!"admin".equalsIgnoreCase(username) ) {
                        session.setAttribute("staffId", accountDAO.getStaffIdByUsername(username));
                    }

                    final String destinationPage = "admin".equalsIgnoreCase(username)
                            ? "HomeDashBoard_Admin.jsp"
                            : "Top_selling"; // cái này là trang của Dash board staff

                    response.sendRedirect(destinationPage);
                    return;
                } else if (status == 1) { // Tài khoản bị chặn
                    request.setAttribute("errorMessage", "Tài khoản của bạn đã bị chặn. Vui lòng liên hệ với quản trị viên!");
                }
            } else {
                request.setAttribute("errorMessage", "Tên người dùng hoặc mật khẩu không hợp lệ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi máy chủ nội bộ. Vui lòng thử lại sau.");
        }

        // Trả lỗi về JSP
        request.getRequestDispatcher("LoginOfDashboard.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
