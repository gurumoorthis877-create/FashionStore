package com.FashionStore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CartItemDAO;
import com.FashionStore.dao.OrderDAO;
import com.FashionStore.dao.impl.CartItemDAOImpl;
import com.FashionStore.dao.impl.OrderDAOImpl;
import com.FashionStore.model.Order;
import com.FashionStore.model.User;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        cartItemDAO = new CartItemDAOImpl();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("history".equalsIgnoreCase(action) || action == null) {
            List<Order> ordersList = orderDAO.getOrdersByUserId(user.getUserId());
            request.setAttribute("orders", ordersList);

            request.getRequestDispatcher("order-history.jsp").forward(request, response);
        } else {
            response.sendRedirect("products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("placeOrder".equalsIgnoreCase(action)) {
            Integer cartId = (Integer) session.getAttribute("cartId");

            // Generate an integer Order ID to match model (setOrderId(int))
            int orderIdInt = 100000 + new Random().nextInt(900000);
            String orderIdStr = String.valueOf(orderIdInt);

            String paymentMethod = request.getParameter("paymentMethod");
            String address = request.getParameter("address");
            
            // Convert double to BigDecimal to match model (setTotalAmount(BigDecimal))
            BigDecimal totalAmount = BigDecimal.ZERO;
            try {
                if (request.getParameter("totalAmount") != null) {
                    totalAmount = new BigDecimal(request.getParameter("totalAmount"));
                }
            } catch (Exception e) {
                totalAmount = BigDecimal.ZERO;
            }

            // 1. Create and save new Order record
            Order newOrder = new Order();
            newOrder.setOrderId(orderIdInt); // Fixed: passes int
            newOrder.setUserId(user.getUserId());
            newOrder.setTotalAmount(totalAmount); // Fixed: passes BigDecimal
            newOrder.setPaymentMethod(paymentMethod != null ? paymentMethod : "UPI");
            newOrder.setShippingAddress(address);
            newOrder.setOrderStatus("PENDING");

            orderDAO.createOrder(newOrder);

            // 2. Clear items from cart database table
            if (cartId != null) {
                cartItemDAO.clearCart(cartId);
            }

            // 3. Set display attributes for order success screen
            request.setAttribute("orderId", orderIdStr);
            request.setAttribute("paymentMethod", paymentMethod != null ? paymentMethod : "UPI");
            request.setAttribute("shippingAddress", address);

            request.getRequestDispatcher("order-success.jsp").forward(request, response);
        } else {
            response.sendRedirect("cart");
        }
    }
}