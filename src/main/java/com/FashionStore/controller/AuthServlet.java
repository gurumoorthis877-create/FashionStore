package com.FashionStore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CartDAO;
import com.FashionStore.dao.UserDAO;
import com.FashionStore.dao.impl.CartDAOImpl;
import com.FashionStore.dao.impl.UserDAOImpl;
import com.FashionStore.model.Cart;
import com.FashionStore.model.User;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
        cartDAO = new CartDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "register":
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            case "login":
            default:
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            // Default to login processing if action is omitted by login form
            action = "login";
        }

        switch (action) {
            case "register":
                handleRegister(request, response);
                break;
            case "login":
                handleLogin(request, response);
                break;
            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");

        if (userDAO.isEmailRegistered(email)) {
            request.setAttribute("errorMessage", "Email is already registered. Please log in.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setPassword(password);
        newUser.setGender(gender);
        newUser.setAddress(address);
        newUser.setRole("CUSTOMER");

        boolean success = userDAO.registerUser(newUser);

        if (success) {
            User registeredUser = userDAO.getUserByEmail(email);
            if (registeredUser != null) {
                cartDAO.createCart(registeredUser.getUserId());
            }
            request.setAttribute("successMessage", "Registration successful! Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed due to a server error. Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) {
            email = email.trim();
        }

        HttpSession session = request.getSession();

        // 1. Admin Email Authentication Check
        if ("admin@fashionstore.com".equalsIgnoreCase(email) && "admin123".equals(password)) {
            session.setAttribute("adminAuthenticated", "true");
            response.sendRedirect(request.getContextPath() + "/admin?action=products");
            return;
        }

        // 2. Standard User Authentication Check
        User user = userDAO.loginUser(email, password);

        if (user != null) {
            session.setAttribute("user", user);

            Cart cart = cartDAO.getCartByUserId(user.getUserId());
            if (cart != null) {
                session.setAttribute("cartId", cart.getCartId());
            }

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin?action=products");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp?logout=true");
    }
}