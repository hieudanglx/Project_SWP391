/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Dinh Van Do - CE182224
 */

public class ProductForAdmin extends Product {
    private int importPrice;
     private Date date;
    private int importQuantity;
    private String supplier;

    public ProductForAdmin() {
        super();
    }

    public ProductForAdmin(int productID, String productName, int price, int categoryID, String brand, 
                           String cameraFront, String cameraBehind, String ram, String ramType, 
                           String supportsUpgradingRAM, String rom, String supportsUpgradingROM, 
                           String color, String operatingSystemName, String operatingSystemVersion, 
                           String screenSize, String refreshRate, String screenResolution, 
                           String chipType, String chipName, String gpuType, String gpuName, 
                           int quantitySell, int quantityProduct, String imageURL, int isDelete, int importPrice) {
        super(productID, productName, price, categoryID, brand, cameraFront, cameraBehind, ram, ramType, 
              supportsUpgradingRAM, rom, supportsUpgradingROM, color, operatingSystemName, 
              operatingSystemVersion, screenSize, refreshRate, screenResolution, chipType, chipName, 
              gpuType, gpuName, quantitySell, quantityProduct, imageURL, isDelete);
        this.importPrice = importPrice;
    }
    
     public ProductForAdmin(int productID, String productName, int price, int categoryID, String brand, 
                           String cameraFront, String cameraBehind, String ram, String ramType, 
                           String supportsUpgradingRAM, String rom, String supportsUpgradingROM, 
                           String color, String operatingSystemName, String operatingSystemVersion, 
                           String screenSize, String refreshRate, String screenResolution, 
                           String chipType, String chipName, String gpuType, String gpuName, 
                           int quantitySell, int quantityProduct, String imageURL, int isDelete, 
                           int importPrice, Date date, int importQuantity, String supplier) {
        super(productID, productName, price, categoryID, brand, cameraFront, cameraBehind, ram, ramType, 
              supportsUpgradingRAM, rom, supportsUpgradingROM, color, operatingSystemName, 
              operatingSystemVersion, screenSize, refreshRate, screenResolution, chipType, chipName, 
              gpuType, gpuName, quantitySell, quantityProduct, imageURL, isDelete);
        this.importPrice = importPrice;
        this.date = date;
        this.importQuantity = importQuantity;
        this.supplier = supplier;
    }

    public int getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(int importPrice) {
        this.importPrice = importPrice;
    }
    
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getImportQuantity() {
        return importQuantity;
    }

    public void setImportQuantity(int importQuantity) {
        this.importQuantity = importQuantity;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }
}



