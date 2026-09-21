package com.FashionStore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestDBConnection {

    // Database connection details matching your setup
    private static final String URL = "jdbc:mysql://localhost:3306/fashion_store?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    // Static block to register the MySQL Driver once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Check Maven dependency.", e);
        }
    }

    /**
     * Obtains a connection to the database.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Main method for testing the database connection.
     */
    public static void main(String[] args) {
        System.out.println("Testing Database Connection...");

        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("==========================================");
                System.out.println("SUCCESS: Connected to 'fashion_store' DB!");
                System.out.println("Connection Details: " + conn.getMetaData().getURL());
                System.out.println("==========================================");
            }
        } catch (SQLException e) {
            System.err.println("==========================================");
            System.err.println("FAILURE: Unable to connect to the database.");
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("==========================================");
            e.printStackTrace();
        }
    }
}