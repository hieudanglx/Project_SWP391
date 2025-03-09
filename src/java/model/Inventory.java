/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class Inventory {

    private int ProductID;
    private String productName;
    private Date DATE;
    private int Import_price;
    private int price;
    private int Import_quantity;
    private int quantityProduct;
    private int quantitySell;
    private String Supplier;

    public Inventory() {
    }

    public Inventory(int ProductID, String productName, int Import_price, int price, int Import_quantity, int quantityProduct, int quantitySell, String Supplier) {
        this.ProductID = ProductID;
        this.productName = productName;
        this.Import_price = Import_price;
        this.price = price;
        this.Import_quantity = Import_quantity;
        this.quantityProduct = quantityProduct;
        this.quantitySell = quantitySell;
        this.Supplier = Supplier;
    }

    
    public Inventory(int ProductID, String productName, Date DATE, int Import_price, int price,  int quantityProduct, int quantitySell, String Supplier) {
        this.ProductID = ProductID;
        this.productName = productName;
        this.DATE = DATE;
        this.Import_price = Import_price;
        this.price = price;
    
        this.quantityProduct = quantityProduct;
        this.quantitySell = quantitySell;
        this.Supplier = Supplier;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getImport_price() {
        return Import_price;
    }

    public void setImport_price(int Import_price) {
        this.Import_price = Import_price;
    }

    public Date getDATE() {
        return DATE;
    }

    public void setDATE(Date DATE) {
        this.DATE = DATE;
    }

    public int getImport_quantity() {
        return Import_quantity;
    }

    public void setImport_quantity(int Import_quantity) {
        this.Import_quantity = Import_quantity;
    }

    public String getSupplier() {
        return Supplier;
    }

    public void setSupplier(String Supplier) {
        this.Supplier = Supplier;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantityProduct() {
        return quantityProduct;
    }

    public void setQuantityProduct(int quantityProduct) {
        this.quantityProduct = quantityProduct;
    }

    public int getQuantitySell() {
        return quantitySell;
    }

    public void setQuantitySell(int quantitySell) {
        this.quantitySell = quantitySell;
    }

    @Override
    public String toString() {
        return "Inventory{" + "ProductID=" + ProductID + ", productName=" + productName + ", DATE=" + DATE + ", Import_price=" + Import_price + ", price=" + price + ", Import_quantity=" + Import_quantity + ", quantityProduct=" + quantityProduct + ", quantitySell=" + quantitySell + ", Supplier=" + Supplier + '}';
    }
    
    

}
