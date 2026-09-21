package com.FashionStore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.FashionStore.dao.UserDAO;
import com.FashionStore.dao.impl.UserDAOImpl;
import com.FashionStore.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to the registration JSP page on GET request
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve form input parameters from register.jsp
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        // Instantiate User model and map using exact model methods
        User user = new User();
        user.setFullName(name);  // Fix: setFullName instead of setName
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setGender(gender);
        user.setAddress(address);
        user.setRole("CUSTOMER"); // Default user role

        // Execute registration via UserDAO
        UserDAO userDAO = new UserDAOImpl();
        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            // Forward to login page with success message
            request.setAttribute("successMessage", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Reload registration page with error message
            request.setAttribute("errorMessage", "Registration failed! Email might already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}