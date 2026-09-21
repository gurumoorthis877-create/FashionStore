package com.FashionStore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = System.getenv("DB_URL") != null 
        ? System.getenv("DB_URL") 
        : "jdbc:mysql://mysql-131b3ca7-gurumoorthis877-6c0d.h.aivencloud.com:20898/defaultdb?sslmode=require";

    private static final String USERNAME = System.getenv("DB_USER") != null 
        ? System.getenv("DB_USER") 
        : "avnadmin";

    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}