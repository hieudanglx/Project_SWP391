/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nguye
 */
@WebServlet("/UploadAvatarController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadAvatarController extends HttpServlet {

    private static final String UPLOAD_DIR = "images/avatars";
    private static final Logger LOGGER = Logger.getLogger(UploadAvatarController.class.getName());
    private CustomerDAO cus = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer customerID = (Integer) session.getAttribute("customerID");

        if (customerID == null) {
            LOGGER.log(Level.WARNING, "Unauthorized access: No customerID found in session.");
            response.sendRedirect("login.jsp");
            return;
        }

        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            LOGGER.log(Level.WARNING, "No file uploaded.");
            response.sendRedirect("ViewProfileOfCustomer.jsp?error=No file selected");
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Validate file extension (Only allow JPG, PNG, JPEG)
        if (!fileName.matches("(?i).+\\.(jpg|jpeg|png)$")) {
            LOGGER.log(Level.WARNING, "Invalid file type: " + fileName);
            response.sendRedirect("ViewProfileOfCustomer.jsp?error=Invalid file type");
            return;
        }

        // Generate unique file name
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

        // Determine upload directory path
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        System.out.println(filePath);
        filePart.write(filePath);

        // Save path in database (relative path)
        String avatarPath = UPLOAD_DIR + "/" + uniqueFileName;
        if (cus.updateAvatar(customerID, avatarPath)) {
            session.setAttribute("avatarPath", avatarPath);
            response.sendRedirect("ViewProfileOfCustomer.jsp?success=Avatar updated");
        } else {
            response.sendRedirect("ViewProfileOfCustomer.jsp?error=Failed to update avatar");
        }
    }
}