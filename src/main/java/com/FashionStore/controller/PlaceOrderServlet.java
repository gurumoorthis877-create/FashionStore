package com.FashionStore.controller;

import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CartItemDAO;
import com.FashionStore.dao.impl.CartItemDAOImpl;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;

    @Override
    public void init() throws ServletException {
        cartItemDAO = new CartItemDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Integer cartId = (Integer) session.getAttribute("cartId");
        if (cartId == null) {
            cartId = 1;
        }

        // Retrieve form details submitted from checkout.jsp
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        String totalAmountStr = request.getParameter("totalAmount");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "Cash on Delivery";
        }

        // Generate dynamic random Order ID (e.g., FS-582914)
        Random random = new Random();
        int randomNum = 100000 + random.nextInt(900000);
        String generatedOrderId = "FS-" + randomNum;

        // Clear cart items from database post-purchase
        cartItemDAO.clearCart(cartId);

        // Pass attributes for order-success.jsp
        request.setAttribute("orderId", generatedOrderId);
        request.setAttribute("fullName", fullName);
        request.setAttribute("address", address);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("totalAmount", totalAmountStr);

        request.getRequestDispatcher("order-success.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}