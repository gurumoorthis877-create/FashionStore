<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.CartItem" %>
<jsp:include page="header.jsp" />

<div class="container my-5">
    <h2 class="mb-4"><i class="fa-solid fa-cart-shopping me-2"></i>Shopping Cart</h2>

    <% 
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
        
        // Dynamic subtotal calculation
        double calculatedTotal = 0.0;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                calculatedTotal += item.getUnitPrice() * item.getQuantity();
            }
        }

        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="row">
            <div class="col-lg-8 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" class="ps-4">Product</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Subtotal</th>
                                        <th scope="col" class="text-end pe-4">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (CartItem item : cartItems) { 
                                        double lineTotal = item.getUnitPrice() * item.getQuantity();
                                        String imageUrl = (item.getImageUrl() != null && !item.getImageUrl().trim().isEmpty())
                                                            ? item.getImageUrl()
                                                            : "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500";
                                    %>
                                        <tr>
                                            <td class="ps-4">
                                                <div class="d-flex align-items-center">
                                                    <img src="<%= imageUrl %>" 
                                                         class="rounded me-3" 
                                                         style="width: 60px; height: 60px; object-fit: cover;" 
                                                         alt="<%= item.getProductName() != null ? item.getProductName() : "Product" %>"
                                                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500';">
                                                    <div>
                                                        <h6 class="mb-0 fw-bold"><%= item.getProductName() != null ? item.getProductName() : "Item #" + item.getVariantId() %></h6>
                                                        <small class="text-muted"><%= item.getVariantDetails() != null ? item.getVariantDetails() : "Standard" %></small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="fw-semibold">₹<%= item.getUnitPrice() %></td>
                                            <td style="width: 140px;">
                                                <form action="cart" method="post" class="d-flex align-items-center">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                                    <input type="number" name="quantity" class="form-control form-control-sm me-2" value="<%= item.getQuantity() %>" min="1" max="10">
                                                    <button type="submit" class="btn btn-outline-secondary btn-sm" title="Update"><i class="fa-solid fa-rotate"></i></button>
                                                </form>
                                            </td>
                                            <td class="fw-bold text-primary">₹<%= lineTotal %></td>
                                            <td class="text-end pe-4">
                                                <form action="cart" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('Remove this item from cart?');">
                                                        <i class="fa-solid fa-trash-can"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Summary Card -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h5 class="card-title fw-bold mb-3">Order Summary</h5>
                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Subtotal</span>
                            <span class="fw-bold">₹<%= calculatedTotal %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Estimated Shipping</span>
                            <span class="text-success fw-bold">FREE</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-4 fs-5 fw-bold">
                            <span>Total</span>
                            <span class="text-primary">₹<%= calculatedTotal %></span>
                        </div>
                        <a href="checkout" class="btn btn-success btn-lg w-100">Proceed to Checkout <i class="fa-solid fa-arrow-right ms-2"></i></a>
                        <a href="products" class="btn btn-link w-100 mt-2 text-decoration-none">Continue Shopping</a>
                    </div>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="text-center py-5">
            <i class="fa-solid fa-basket-shopping fs-1 text-muted mb-3"></i>
            <h4>Your cart is empty</h4>
            <p class="text-muted">Looks like you haven't added anything to your cart yet.</p>
            <a href="products" class="btn btn-primary mt-2">Start Shopping</a>
        </div>
    <% } %>
</div>

<jsp:include page="footer.jsp" />