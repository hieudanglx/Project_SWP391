/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Tran Phong Hai - CE180803
 */
public class Order_Details {
    private int OrderDetaiID;
    private int Quantity;
    private int ProductID;
    private int OrderID;

    public Order_Details() {
    }

    public Order_Details(int OrderDetaiID, int Quantity, int ProductID, int OrderID) {
        this.OrderDetaiID = OrderDetaiID;
        this.Quantity = Quantity;
        this.ProductID = ProductID;
        this.OrderID = OrderID;
    }
    

    public int getOrderDetaiID() {
        return OrderDetaiID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public int getProductID() {
        return ProductID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderDetaiID(int OrderDetaiID) {
        this.OrderDetaiID = OrderDetaiID;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }
    
    
}
