package com.FashionStore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CartItemDAO;
import com.FashionStore.dao.ProductDAO;
import com.FashionStore.dao.ProductVariantDAO;
import com.FashionStore.dao.impl.CartItemDAOImpl;
import com.FashionStore.dao.impl.ProductDAOImpl;
import com.FashionStore.dao.impl.ProductVariantDAOImpl;
import com.FashionStore.model.CartItem;
import com.FashionStore.model.Product;
import com.FashionStore.model.ProductVariant;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartItemDAO cartItemDAO;
    private ProductVariantDAO variantDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        cartItemDAO = new CartItemDAOImpl();
        variantDAO = new ProductVariantDAOImpl();
        productDAO = new ProductDAOImpl();
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

        List<CartItem> cartItems = cartItemDAO.getItemsByCartId(cartId);
        double subtotal = 0.0;

        if (cartItems != null) {
            for (CartItem item : cartItems) {
                ProductVariant variant = variantDAO.getVariantById(item.getVariantId());
                if (variant != null) {
                    Product product = productDAO.getProductById(variant.getProductId());
                    if (product != null) {
                        item.setProductName(product.getProductName());
                        item.setImageUrl(product.getImageUrl());

                        Object priceObj = product.getBasePrice();
                        double priceVal = 0.0;
                        if (priceObj instanceof BigDecimal) {
                            priceVal = ((BigDecimal) priceObj).doubleValue();
                        } else if (priceObj instanceof Double) {
                            priceVal = (Double) priceObj;
                        } else if (priceObj instanceof Number) {
                            priceVal = ((Number) priceObj).doubleValue();
                        }
                        item.setUnitPrice(priceVal);
                        item.setVariantDetails(variant.getSize() + " / " + variant.getColor());
                        subtotal += (priceVal * item.getQuantity());
                    }
                }
            }
        } else {
            cartItems = new ArrayList<>();
        }

        // Standard shipping fee (e.g. ₹50 standard fee, Free if subtotal > ₹500)
        double shippingFee = (subtotal > 0 && subtotal < 500) ? 50.0 : 0.0;
        double grandTotal = subtotal + shippingFee;

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("grandTotal", grandTotal);

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}