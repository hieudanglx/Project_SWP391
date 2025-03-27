//
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import dao.ProductDao;

@WebServlet(name = "createProduct", urlPatterns = {"/createProduct"})
public class createProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("createProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ form
            String productName = request.getParameter("productName");
            int price = Integer.parseInt(request.getParameter("price"));
            int categoryID = Integer.parseInt(request.getParameter("category"));
            String brand = request.getParameter("brand");
            String operatingSystemName = request.getParameter("os");
            String operatingSystemVersion = request.getParameter("version");
            String ram = request.getParameter("ram");
            String rom = request.getParameter("storage");
            String color = request.getParameter("color");
            String screenSize = request.getParameter("size");
            String cameraBehind = request.getParameter("rearCamera");
            String cameraFront = request.getParameter("frontCamera");
            String chipType = request.getParameter("chiptype");
            String chipName = request.getParameter("chip");
            String refreshRate = request.getParameter("refreshRate");
            String screenResolution = request.getParameter("screenResolution");
            String width = request.getParameter("resolutionWidth");
            String height = request.getParameter("resolutionHeight");
            String chipGeneration = request.getParameter("chipGeneration");
            String gputype = request.getParameter("gpuType");
            String gpuName = request.getParameter("gpuName");
            String ramType = request.getParameter("ramType");
            String supportsUpgradingRAM = request.getParameter("supportsUpgradingRAM");
            String supportsUpgradingROM = request.getParameter("supportsUpgradingROM");
            String imageURL = request.getParameter("imageURL");
            int isDelete = 0; // Mặc định là chưa bị xóa

            if (categoryID == 1) {
                chipName += " " + chipGeneration;
            }

            // Xử lý các giá trị tùy chỉnh (nếu người dùng chọn "other")
            if (brand.equals("other")) {
                brand = request.getParameter("brand_custom");
                request.setAttribute("brand_custom", brand);
            }

            if (operatingSystemName.equals("other")) {
                operatingSystemName = request.getParameter("os_custom");
                request.setAttribute("os_custom", operatingSystemName);
            }

            if (ram.equals("other")) {
                ram = request.getParameter("ram_custom");
                request.setAttribute("ram_custom", ram);
            }

            if (rom.equals("other")) {
                rom = request.getParameter("storage_custom");
                request.setAttribute("storage_custom", rom);
            }

            if (refreshRate.equals("other")) {
                refreshRate = request.getParameter("refreshRate_custom");
                request.setAttribute("refreshRate_custom", refreshRate);
            }

            if (screenResolution.equals("other")) {
                screenResolution = request.getParameter("screenResolution_custom");
                request.setAttribute("screenResolution_custom", screenResolution);
            }
            if (ramType.equals("other")) {
                ramType = request.getParameter("ramType_custom");
                request.setAttribute("ramType_custom", ramType);
            }
            if (chipType.equals("other")) {
                chipType = request.getParameter("chipType_custom");
                request.setAttribute("chipType_custom", chipType);
            }
            if (chipName.equals("other")) {
                chipName = request.getParameter("chipName_custom");
                request.setAttribute("chipName_custom", chipName);
            }
            if (gputype.equals("other")) {
                gputype = request.getParameter("gputype_custom");
                request.setAttribute("gputype_custom", gputype);
            }

            // Tạo đối tượng Product
            Product product = new Product(
                    0, // productID (tạm thời là 0, sẽ được tạo tự động trong database)
                    productName,
                    price,
                    categoryID,
                    brand,
                    cameraFront,
                    cameraBehind,
                    ram,
                    ramType,
                    supportsUpgradingRAM,
                    rom,
                    supportsUpgradingROM,
                    color,
                    operatingSystemName,
                    operatingSystemVersion,
                    screenSize + " inch",
                    refreshRate,
                    screenResolution + " (" + width + "x" + height + ")",
                    chipType,
                    chipName,
                    gputype,
                    gpuName,
                    0, // quantitySell
                    0, // quantityProduct
                    imageURL,
                    isDelete
            );

            // Kiểm tra xem sản phẩm có tồn tại không
            ProductDao productDao = new ProductDao();
            boolean exist = false;

            if (categoryID == 2 || categoryID == 3) { // Điện thoại
                exist = productDao.isProductExists(product);
            } else if (categoryID == 1) { // Laptop
                exist = productDao.isLaptopExists(product);
            }

            if (exist) {

                // Nếu sản phẩm đã tồn tại, truyền thông tin lỗi và dữ liệu về JSP
                request.setAttribute("error", "Product already exists. Please change 1 of the following 4 data fields: Phone Name,Color,RAM,Storage Capacity.");
                request.setAttribute("product", product);

                // Truyền các giá trị tùy chỉnh về JSP
                request.setAttribute("brand", brand);
                request.setAttribute("ram", ram);
                request.setAttribute("storage", rom);
                request.setAttribute("os", operatingSystemName);
                request.setAttribute("refreshRate", refreshRate);
                request.setAttribute("screenResolution", screenResolution);
                request.setAttribute("screenSize", Integer.parseInt(screenSize));
                request.setAttribute("width", Integer.parseInt(width));
                request.setAttribute("height", Integer.parseInt(height));
                request.setAttribute("chipGeneration", chipGeneration);
                request.setAttribute("ramType", ramType);
                request.setAttribute("chipType", chipType);
                request.setAttribute("chipName", chipName);
                request.setAttribute("gputype", gputype);

                // Chuyển hướng về trang JSP
                if (categoryID == 2) {
                    request.getRequestDispatcher("createProduct.jsp").forward(request, response);
                } else if (categoryID == 3) {
                    request.getRequestDispatcher("createTablet.jsp").forward(request, response);

                } else if (categoryID == 1) {
                    request.getRequestDispatcher("createLaptop.jsp").forward(request, response);
                }
            } else {
                // Nếu sản phẩm không tồn tại, thêm vào database
                boolean isAdded = productDao.addProduct(product);

                // Chuyển hướng về trang JSP
                if (categoryID == 2) {

                    if (isAdded) {
                        response.sendRedirect("createProduct.jsp?success=true");
                    } else {
                        response.sendRedirect("createProduct.jsp?error=Failed to create Phone.");
                    }
//                    response.sendRedirect("createProduct.jsp?message=Product created successfully.");
                } else if (categoryID == 3) {

                    if (isAdded) {
                        response.sendRedirect("createTablet.jsp?error=Tablet created successfully.");
                    } else {
                        response.sendRedirect("createTablet.jsp?error=Failed to create Tablet.");
                    }
//                    request.getRequestDispatcher("createTablet.jsp").forward(request, response);
                } else if (categoryID == 1) {

                    if (isAdded) {
                        response.sendRedirect("createLaptop.jsp?error=Laptop created successfully.");
                    } else {
                        response.sendRedirect("createLaptop.jsp?error=Failed to create Laptop.");
                    }
//                    request.getRequestDispatcher("createLaptop.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu người dùng nhập sai định dạng số
            request.setAttribute("error", "Invalid input for price, category, or other numeric fields.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý các lỗi khác
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for creating a new product";
    }
}
