<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.FashionStore.model.Order" %>
<jsp:include page="header.jsp" />

<%
    Order order = (Order) request.getAttribute("order");
%>

<div class="container my-5 text-center">
    <% if (order != null) { %>
        <div class="card border-0 shadow-sm mx-auto p-4" style="max-width: 600px;">
            <div class="card-body">
                <div class="text-success mb-3">
                    <i class="fa-solid fa-circle-check fa-4x"></i>
                </div>
                <h2 class="fw-bold mb-2">Thank You for Your Order!</h2>
                <p class="text-muted mb-4">Your order has been placed successfully and is being processed.</p>

                <div class="bg-light p-3 rounded text-start mb-4">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Order ID:</span>
                        <span class="fw-bold">#<%= order.getOrderId() %></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Total Amount:</span>
                        <span class="fw-bold text-primary">$<%= order.getTotalAmount() %></span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Payment Method:</span>
                        <span class="fw-bold"><%= order.getPaymentMethod() %></span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted">Status:</span>
                        <span class="badge bg-warning text-dark"><%= order.getOrderStatus() %></span>
                    </div>
                </div>

                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                    <a href="order?action=history" class="btn btn-outline-primary btn-lg px-4 me-md-2">View Order History</a>
                    <a href="products" class="btn btn-primary btn-lg px-4">Continue Shopping</a>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="py-5">
            <i class="fa-solid fa-circle-exclamation fs-1 text-danger mb-3"></i>
            <h3>No Order Information Found</h3>
            <p class="text-muted">It seems you landed on this page without completing an order.</p>
            <a href="products" class="btn btn-primary mt-2">Return to Shop</a>
        </div>
    <% } %>
</div>

<jsp:include page="footer.jsp" />