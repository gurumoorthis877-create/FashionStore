package com.FashionStore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Aiven Cloud MySQL Connection Details
    private static final String URL = "jdbc:mysql://mysql-131b3ca7-gurumoorthis877-6c0d.h.aivencloud.com:20898/defaultdb?sslmode=require";
    private static final String USERNAME = "avnadmin";
    private static final String PASSWORD = "AVNS_cJ5vCfJ1WB5VoH6NnwP";

    static {
        try {
            // Register MySQL Connector Driver (MySQL 8+)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}