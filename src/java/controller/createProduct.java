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
        String productName = request.getParameter("productName");
        int price = Integer.parseInt(request.getParameter("price"));
        int categoryID = Integer.parseInt(request.getParameter("category"));
        String brand = request.getParameter("brand");
        String brandCustom = null;
        if ("other".equals(brand)) {
            brandCustom = request.getParameter("brand_custom");
        }
        request.setAttribute("brand", brand);
        request.setAttribute("brand_custom", brandCustom);
        String operatingSystemName = request.getParameter("os");
        String osCustom = null;
        if ("other".equals(operatingSystemName)) {
            osCustom = request.getParameter("os_custom");
        }
        request.setAttribute("os", operatingSystemName);
        request.setAttribute("os_custom", osCustom);

        String operatingSystemVersion = request.getParameter("version");
        String ram = request.getParameter("ram");
        String ramCustom = null;
        if ("other".equals(ram)) {
            ramCustom = request.getParameter("ram_custom");
        }
        request.setAttribute("ram", ram);
        request.setAttribute("ram_custom", ramCustom);

        String rom = request.getParameter("storage");
        String storageCustom = null;
        if ("other".equals(rom)) {
            storageCustom = request.getParameter("storage_custom");
        }
        request.setAttribute("storage", rom);
        request.setAttribute("storage_custom", storageCustom);

        String color = request.getParameter("color");
        String screenSize = request.getParameter("size");
        String cameraBehind = request.getParameter("rearCamera");
//        request.setAttribute("cameraBehind", cameraBehind);
        String cameraFront = request.getParameter("frontCamera");
//        request.setAttribute("cameraFront", cameraFront);
        String chipType = request.getParameter("chiptype");
        String chipName = request.getParameter("chip");
        String refreshRate = request.getParameter("refreshRate");
        String refreshRateCustom = null;
        if ("other".equals(refreshRate)) {
            refreshRateCustom = request.getParameter("refreshRate_custom");
        }
        request.setAttribute("refreshRate", refreshRate);
        request.setAttribute("refreshRate_custom", refreshRateCustom);

        String screenResolution = request.getParameter("screenResolution");
        String screenResolutionCustom = null;
        if ("other".equals(screenResolution)) {
            screenResolutionCustom = request.getParameter("screenResolution_custom");
        }
        request.setAttribute("screenResolution", screenResolution);
        request.setAttribute("screenResolution_custom", screenResolutionCustom);

        String width = request.getParameter("resolutionWidth");
        String height = request.getParameter("resolutionHeight");
        String gputype = request.getParameter("gpuType");
        String gpuName = request.getParameter("gpuName");
        String ramType = request.getParameter("ramType");
        String supportsUpgradingRAM = request.getParameter("supportsUpgradingRAM");
        String supportsUpgradingROM = request.getParameter("supportsUpgradingROM");
        String imageURL = request.getParameter("imageURL");
        int isDelete = 0; // Mặc định là chưa bị xóa

        if (brand.equals("other")) {
            brand = request.getParameter("brand_custom");
        }

        if (operatingSystemName.equals("other")) {
            operatingSystemName = request.getParameter("os_custom");
        }
        if (ram.equals("other")) {
            ram = request.getParameter("ram_custom");
        }
        if (rom.equals("other")) {
            rom = request.getParameter("storage_custom");
        }
        if (refreshRate.equals("other")) {
            refreshRate = request.getParameter("refreshRate_custom");
        }
        if (screenResolution.equals("other")) {
            brand = request.getParameter("screenResolution_custom");
        }
        screenResolution += " (" + width + "x" + height + ")";

        Product product = new Product(
                0,
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
                screenResolution,
                chipType,
                chipName,
                gputype,
                gpuName,
                0, // quantitySell 
                0, // quantityProduct 
                imageURL,
                isDelete
        );

        ProductDao productDao = new ProductDao();
        if (categoryID == 2|| categoryID==3) {
            boolean exist = productDao.isProductExists(product);
            if (exist) {
                request.setAttribute("error", "The product has existed");
                request.setAttribute("product", product);

                request.setAttribute("screenSize", Integer.parseInt(screenSize));
                request.setAttribute("width", Integer.parseInt(width));
                request.setAttribute("height", Integer.parseInt(height));
                request.getRequestDispatcher("createProduct.jsp").forward(request, response);
            } else {
                boolean isAdded = productDao.addProduct(product);
                if (isAdded) {
                    request.setAttribute("error", "Create sucessful");
                    request.getRequestDispatcher("createProduct.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to create product");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        } else if (categoryID == 1) {
                boolean exist = productDao.isLaptopExists(product);
                if (exist) {
                request.setAttribute("error", "The product has existed");
                request.setAttribute("product", product);

                request.setAttribute("screenSize", Integer.parseInt(screenSize));
                request.setAttribute("width", Integer.parseInt(width));
                request.setAttribute("height", Integer.parseInt(height));
                request.getRequestDispatcher("createLaptop.jsp").forward(request, response);
            } else {
                boolean isAdded = productDao.addProduct(product);
                if (isAdded) {
                   request.setAttribute("error", "Create sucessful");
                    request.getRequestDispatcher("createLaptop.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to create product");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet for creating a new product";
    }
}
