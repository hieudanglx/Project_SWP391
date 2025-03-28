package controller;

import dao.AccountDao;
import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Customer;
import model.OTPGenerate;
import model.EmailSenderCustomer;

@WebServlet(name = "ChangePasswordOfCustomer", urlPatterns = {"/ChangePasswordOfCustomer"})
public class ChangePasswordOfCustomerController extends HttpServlet {

    private final AccountDao accountDao = new AccountDao(); // Khởi tạo AccountDao

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý khi người dùng truy cập qua GET (tránh lỗi 405)
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not allowed.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            String email = request.getParameter("email");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");
            currentPassword = accountDao.hashPassword(currentPassword);
            // Kiểm tra nếu người dùng chưa đăng nhập
            if (email == null || email.isEmpty()) {

                request.setAttribute("errorMessage", "Bạn chưa đăng nhập hoặc không có email!");
                request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
                return;
            }

            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByEmail(email);

            if (customer == null) {

                request.setAttribute("errorMessage", "Tài khoản không tồn tại!");
                request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
                return;
            }
            System.out.println(customer.getPassword());
            System.out.println(currentPassword);

            // Kiểm tra mật khẩu hiện tại
            if (!customer.getPassword().equals(currentPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng!");
                request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu mới và xác nhận
            if (!newPassword.equals(confirmNewPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
                request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
                return;
            }

            // Kiểm tra trùng mật khẩu cũ
            if (currentPassword.equals(newPassword)) {
                request.setAttribute("errorMessage", "Mật khẩu mới không được trùng với mật khẩu cũ!");
                request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
                return;
            }

            // Gửi OTP qua email
            String otp = OTPGenerate.generateOTP();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            session.setAttribute("tempPassword", newPassword);

            EmailSenderCustomer.sendEmail(email, "Mã OTP đặt lại mật khẩu",
                    "Mã OTP của bạn là: " + otp + "\nVui lòng nhập OTP này để tiếp tục.");

            // Chuyển sang trang xác minh OTP
            request.getRequestDispatcher("verifyOTPChangePC.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi khi gửi email
            request.setAttribute("errorMessage", "Gửi OTP thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/ViewProfileOfCustomer").forward(request, response);
        }
    }
}
