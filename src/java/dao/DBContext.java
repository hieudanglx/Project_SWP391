package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
<<<<<<< HEAD
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Project_SWP";
            String username = "sa";
            String password = "1234";
=======
            String url = "jdbc:sqlserver://HWI\\SQLEXPRESS:1433;databaseName=Project_SWP;encrypt=true;trustServerCertificate=true;";
            String user = "sa";
            String password = "1";
>>>>>>> 5fe0b19 (add register-Huy)
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to database successfully!");
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }
    
      public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        if (dbContext.connection != null) {
            System.out.println("Kết nối thành công!");
        } else {
            System.out.println("Kết nối không thành công!");
        }
    }
}
