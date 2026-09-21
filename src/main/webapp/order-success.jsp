<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<%
    String orderId = (String) request.getAttribute("orderId");
    String paymentMethod = (String) request.getAttribute("paymentMethod");
    String fullName = (String) request.getAttribute("fullName");
    String address = (String) request.getAttribute("address");
    String totalAmount = (String) request.getAttribute("totalAmount");

    if (orderId == null) orderId = "FS-" + (100000 + (int)(Math.random() * 900000));
    if (paymentMethod == null) paymentMethod = "Cash on Delivery";
%>

<div class="container my-5 text-center">
    <div class="card border-0 shadow-sm p-5 mx-auto" style="max-width: 600px;">
        <div class="mb-3">
            <i class="fa-solid fa-circle-check text-success" style="font-size: 80px;"></i>
        </div>
        <h2 class="fw-bold text-success mb-2">Order Placed Successfully!</h2>
        <p class="text-muted fs-5 mb-4">Thank you for shopping with us. Your order has been recorded.</p>

        <div class="bg-light p-4 rounded mb-4 text-start">
            <div class="d-flex justify-content-between mb-2">
                <span class="fw-bold">Order ID:</span>
                <span class="text-primary fw-bold"><%= orderId %></span>
            </div>
            <% if (fullName != null && !fullName.isEmpty()) { %>
            <div class="d-flex justify-content-between mb-2">
                <span class="fw-bold">Customer Name:</span>
                <span class="text-dark"><%= fullName %></span>
            </div>
            <% } %>
            <% if (address != null && !address.isEmpty()) { %>
            <div class="d-flex justify-content-between mb-2">
                <span class="fw-bold">Delivery Address:</span>
                <span class="text-dark text-truncate" style="max-width: 250px;"><%= address %></span>
            </div>
            <% } %>
            <div class="d-flex justify-content-between mb-2">
                <span class="fw-bold">Payment Method:</span>
                <span class="badge bg-info text-dark"><%= paymentMethod %></span>
            </div>
            <% if (totalAmount != null && !totalAmount.isEmpty()) { %>
            <div class="d-flex justify-content-between mb-2">
                <span class="fw-bold">Total Paid:</span>
                <span class="fw-bold text-success">₹<%= totalAmount %></span>
            </div>
            <% } %>
            <div class="d-flex justify-content-between">
                <span class="fw-bold">Status:</span>
                <span class="badge bg-success">Confirmed</span>
            </div>
        </div>

        <div>
            <a href="products" class="btn btn-primary btn-lg px-4 me-2">Continue Shopping</a>
            <a href="products" class="btn btn-outline-secondary btn-lg px-4">My Orders</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />