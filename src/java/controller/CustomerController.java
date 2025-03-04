/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author nguye
 */
import dao.CustomerDAO;
import model.Customer;
import java.util.List;

public class CustomerController {

    private CustomerDAO customerDAO = new CustomerDAO();

    public void getAllCustomers() {
        List<Customer> customers = customerDAO.getAllCustomers();
        for (Customer c : customers) {
            System.out.println(c);
        }
    }

    public void addCustomer(Customer customer) {
        if (customerDAO.isEmailExisted(customer.getEmail())) {
            System.out.println("Email already exists!");
            return;
        }
        customerDAO.addCustomer(customer);
        System.out.println("Customer added successfully!");
    }

    public void updateCustomer(Customer customer) {
        customerDAO.updateCustomer(customer);
        System.out.println("Customer updated successfully!");
    }

    public void deleteCustomer(int id) {
        customerDAO.deleteCustomer(id);
        System.out.println("Customer deleted successfully!");
    }

    public void getCustomerByEmail(String email) {
        Customer customer = customerDAO.getCustomerByEmail(email);
        if (customer != null) {
            System.out.println(customer);
        } else {
            System.out.println("Customer not found.");
        }
    }

//    public static void main(String[] args) {
//        CustomerController controller = new CustomerController();
//
//        // Test get all customers
//        controller.getAllCustomers();
//
//        // Test add new customer
//        //Customer newCustomer = new Customer(0, "JohnDoe", "john@example.com", "123456", "123 Main St", "123456789", "Active", "img.jpg");
//        controller.addCustomer(newCustomer);
//
//        // Test update customer
//        newCustomer.setUsername("JohnUpdated");
//        controller.updateCustomer(newCustomer);
//
//        // Test delete customer
//        controller.deleteCustomer(3);
//    }
}
