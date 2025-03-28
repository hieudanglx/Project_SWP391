/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 *
 * @author TRAN NHU Y - CE182032
 */
public class EmailSenderCustomer {

    public static void sendEmail(String to, String subject, String content) {
        final String fromEmail = "Trannhuy095@gmail.com"; // Email hệ thống
        final String password = "naow zhik ggdw mjkl"; // Mật khẩu ứng dụng Google

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(content);

            Transport.send(message);
            System.out.println(" Email đã gửi thành công!"+to);
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException(" Lỗi khi gửi email: " + e.getMessage());
        }
    }
}
