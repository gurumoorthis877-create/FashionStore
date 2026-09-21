<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.CartItem" %>
<jsp:include page="header.jsp" />

<div class="container my-5">
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-credit-card me-2"></i>Checkout &amp; Payment</h2>
    <div class="row">
        <!-- Order Summary Card -->
        <div class="col-md-5 order-md-2 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white fw-bold">Order Summary</div>
                <div class="card-body">
                    <%
                        @SuppressWarnings("unchecked")
                        List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");
                        Double subtotal = (Double) request.getAttribute("subtotal");
                        Double shippingFee = (Double) request.getAttribute("shippingFee");
                        Double grandTotal = (Double) request.getAttribute("grandTotal");

                        if (subtotal == null) subtotal = 0.0;
                        if (shippingFee == null) shippingFee = 0.0;
                        if (grandTotal == null) grandTotal = 0.0;
                    %>

                    <% if (items != null && !items.isEmpty()) { 
                        for (CartItem item : items) { %>
                            <div class="d-flex justify-content-between mb-2">
                                <div>
                                    <span class="fw-bold"><%= item.getProductName() != null ? item.getProductName() : "Product" %></span>
                                    <small class="text-muted d-block">Qty: <%= item.getQuantity() %> x ₹<%= item.getUnitPrice() %></small>
                                </div>
                                <span class="fw-bold">₹<%= (item.getUnitPrice() * item.getQuantity()) %></span>
                            </div>
                    <%  } 
                    } else { %>
                        <p class="text-muted text-center">No items in your cart.</p>
                    <% } %>

                    <hr>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Product Subtotal</span>
                        <strong class="text-dark">₹<%= subtotal %></strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Delivery / Shipping Fee</span>
                        <strong class="text-muted"><%= shippingFee == 0.0 ? "Free" : "₹" + shippingFee %></strong>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between fs-5 fw-bold">
                        <span>Total Payable</span>
                        <span class="text-primary">₹<%= grandTotal %></span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Shipping & Payment Details Form -->
        <div class="col-md-7 order-md-1">
            <form action="order" method="post" class="card p-4 shadow-sm border-0">
                <input type="hidden" name="action" value="placeOrder">
                
                <h5 class="fw-bold mb-3"><i class="fa-solid fa-truck-fast me-2"></i>Shipping Address</h5>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Full Name</label>
                    <input type="text" name="fullName" class="form-control" placeholder="Enter your full name" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Delivery Address</label>
                    <textarea name="address" class="form-control" rows="3" placeholder="Street address, City, Pincode" required></textarea>
                </div>
                
                <h5 class="fw-bold my-3"><i class="fa-solid fa-wallet me-2"></i>Payment Method</h5>
                
                <div class="form-check mb-2">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked onclick="togglePaymentSection()">
                    <label class="form-check-label fw-semibold" for="cod">Cash on Delivery (COD)</label>
                </div>
                
                <div class="form-check mb-2">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="upi" value="UPI" onclick="togglePaymentSection()">
                    <label class="form-check-label fw-semibold" for="upi">UPI / Scan &amp; Pay</label>
                </div>

                <!-- UPI QR Code Display Container -->
                <div id="upiQrSection" class="my-3 text-center p-3 border rounded bg-light d-none">
                    <p class="fw-bold text-dark mb-2">Scan QR Code to Pay ₹<%= grandTotal %></p>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=upi://pay?pa=fashionstore@upi%26pn=FashionStore%26am=<%= grandTotal %>" 
                         alt="UPI QR Code" 
                         class="img-fluid border p-2 bg-white rounded shadow-sm">
                    <small class="text-muted d-block mt-2">Scan using Google Pay, PhonePe, or Paytm</small>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="card" value="CARD" onclick="togglePaymentSection()">
                    <label class="form-check-label fw-semibold" for="card">Credit / Debit Card</label>
                </div>

                <input type="hidden" name="totalAmount" value="<%= grandTotal %>">
                <button type="submit" class="btn btn-success btn-lg w-100 mt-3">
                    Place Order (₹<%= grandTotal %>)
                </button>
            </form>
        </div>
    </div>
</div>

<script>
function togglePaymentSection() {
    var upiRadio = document.getElementById("upi");
    var upiSection = document.getElementById("upiQrSection");
    
    if (upiRadio.checked) {
        upiSection.classList.remove("d-none");
    } else {
        upiSection.classList.add("d-none");
    }
}
</script>

<jsp:include page="footer.jsp" />