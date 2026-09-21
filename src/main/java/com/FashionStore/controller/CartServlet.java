package com.FashionStore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CartItemDAO;
import com.FashionStore.dao.impl.CartItemDAOImpl;
import com.FashionStore.model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartItemDAO cartItemDAO;

    @Override
    public void init() throws ServletException {
        cartItemDAO = new CartItemDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Integer cartId = (Integer) session.getAttribute("cartId");
        if (cartId == null) {
            cartId = 1;
            session.setAttribute("cartId", cartId);
        }

        String action = request.getParameter("action");

        // Support both "itemId" and "cartItemId" parameter names
        String itemIdStr = request.getParameter("cartItemId");
        if (itemIdStr == null || itemIdStr.isEmpty()) {
            itemIdStr = request.getParameter("itemId");
        }

        if ("remove".equalsIgnoreCase(action)) {
            if (itemIdStr != null && !itemIdStr.isEmpty()) {
                int cartItemId = Integer.parseInt(itemIdStr);
                cartItemDAO.removeCartItem(cartItemId);
            }
            response.sendRedirect("cart");
            return;
        } else if ("update".equalsIgnoreCase(action)) {
            String qtyStr = request.getParameter("quantity");
            if (itemIdStr != null && qtyStr != null) {
                int cartItemId = Integer.parseInt(itemIdStr);
                int quantity = Integer.parseInt(qtyStr);
                if (quantity > 0) {
                    cartItemDAO.updateQuantity(cartItemId, quantity);
                } else {
                    cartItemDAO.removeCartItem(cartItemId);
                }
            }
            response.sendRedirect("cart");
            return;
        }

        List<CartItem> cartItems = cartItemDAO.getItemsByCartId(cartId);
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        Integer cartId = (Integer) session.getAttribute("cartId");
        if (cartId == null) {
            cartId = 1;
            session.setAttribute("cartId", cartId);
        }

        String action = request.getParameter("action");

        // Support both "itemId" and "cartItemId" parameter names
        String itemIdStr = request.getParameter("cartItemId");
        if (itemIdStr == null || itemIdStr.isEmpty()) {
            itemIdStr = request.getParameter("itemId");
        }

        if ("add".equalsIgnoreCase(action)) {
            String variantIdStr = request.getParameter("variantId");
            String quantityStr = request.getParameter("quantity");

            if (variantIdStr != null && quantityStr != null) {
                int variantId = Integer.parseInt(variantIdStr);
                int quantity = Integer.parseInt(quantityStr);

                CartItem existingItem = cartItemDAO.getCartItem(cartId, variantId);

                if (existingItem != null) {
                    int newQuantity = existingItem.getQuantity() + quantity;
                    cartItemDAO.updateQuantity(existingItem.getCartItemId(), newQuantity);
                } else {
                    CartItem newItem = new CartItem();
                    newItem.setCartId(cartId);
                    newItem.setVariantId(variantId);
                    newItem.setQuantity(quantity);
                    cartItemDAO.addCartItem(newItem);
                }
            }
        } else if ("remove".equalsIgnoreCase(action)) {
            if (itemIdStr != null && !itemIdStr.isEmpty()) {
                int cartItemId = Integer.parseInt(itemIdStr);
                cartItemDAO.removeCartItem(cartItemId);
            }
        } else if ("update".equalsIgnoreCase(action)) {
            String qtyStr = request.getParameter("quantity");
            if (itemIdStr != null && qtyStr != null) {
                int cartItemId = Integer.parseInt(itemIdStr);
                int quantity = Integer.parseInt(qtyStr);
                if (quantity > 0) {
                    cartItemDAO.updateQuantity(cartItemId, quantity);
                } else {
                    cartItemDAO.removeCartItem(cartItemId);
                }
            }
        }

        response.sendRedirect("cart");
    }
}