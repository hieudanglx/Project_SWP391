/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.AccountDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.AccountStaff;
/**
 *
 * @author nguye
 */
@WebServlet(name = "ForgotPasswordStaffController", urlPatterns = {"/forgotPasswordStaff"})
public class ForgotPasswordStaffController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgotPasswordStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDao dao = new AccountDao();
        String email = request.getParameter("email");

        // Kiểm tra nhân viên dựa trên email
        AccountStaff staff = dao.getAccountStaffByEmail(email);

        if (staff == null) {
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            return;
        }

        // Tạo mật khẩu mới
        String newPassword = generateSecurePassword();
        staff.setPassword(newPassword);

        // Cập nhật mật khẩu mới trong database
        boolean isUpdated = dao.updateAccountStaff(staff);
        if (!isUpdated) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // Gửi email thông báo mật khẩu mới
        String subject = "Your New Password - Electronic Store";
        String body = "<html><body>"
                + "<p>Dear " + staff.getFullName() + ",</p>"
                + "<p>We have received a request to reset your password.</p>"
                + "<p>Your new password is: <b>" + newPassword + "</b></p>"
                + "<p>Please log in and change your password for security reasons.</p>"
                + "<p>Best regards,<br>Electronic Store Team</p>"
                + "</body></html>";
response.sendRedirect("index.");
//        sendEmail(email, subject, body);
    }

    private boolean sendEmail(String to, String subject, String body) {
        String host = "smtp.gmail.com";
        String port = "587";
        String username = "electronicstore.support@gmail.com"; // Email hệ thống
        String password = "your-email-password"; // Mật khẩu email hệ thống
        final String finalUsername = username;
        final String finalPassword = password;

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator authenticator = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(finalUsername, finalPassword);
            }
        };

        Session session = Session.getInstance(props, authenticator);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject, "UTF-8");
            message.setContent(body, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;
        } catch (MessagingException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    private String generateSecurePassword() {
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String allChars = upperCase + lowerCase + numbers;

        Random random = new Random();
        int length = 8 + random.nextInt(9); // Tạo mật khẩu từ 8 đến 16 ký tự

        StringBuilder password = new StringBuilder();
        password.append(upperCase.charAt(random.nextInt(upperCase.length()))); // Ít nhất một chữ in hoa
        password.append(numbers.charAt(random.nextInt(numbers.length()))); // Ít nhất một số

        for (int i = 2; i < length; i++) {
            password.append(allChars.charAt(random.nextInt(allChars.length())));
        }

        return password.toString();
    }
}
