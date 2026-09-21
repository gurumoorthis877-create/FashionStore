<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Product" %>
<%@ page import="com.FashionStore.model.ProductVariant" %>
<%@ page import="com.FashionStore.model.Category" %>
<jsp:include page="header.jsp" />

<%
    Product product = (Product) request.getAttribute("product");
    @SuppressWarnings("unchecked")
    List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
    Category category = (Category) request.getAttribute("category");
%>

<div class="container my-5">
    <% if (product != null) { 
        String rawImg = product.getImageUrl();
        String finalImg = (rawImg != null && !rawImg.trim().isEmpty()) 
            ? (rawImg.startsWith("http") ? rawImg : request.getContextPath() + "/" + rawImg)
            : "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500";
    %>
        <div class="row">
            <!-- Product Image -->
            <div class="col-md-6 mb-4">
                <img src="<%= finalImg %>" 
                     class="img-fluid rounded shadow-sm w-100" 
                     style="max-height: 500px; object-fit: cover;" 
                     alt="<%= product.getProductName() %>"
                     onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500';">
            </div>

            <!-- Product Specs & Selection Form -->
            <div class="col-md-6">
                <span class="badge bg-secondary mb-2"><%= category != null ? category.getCategoryName() : "General" %></span>
                <h1 class="fw-bold"><%= product.getProductName() %></h1>
                
                <h3 class="text-primary fw-bold my-3">₹<%= product.getBasePrice() %></h3>
                <p class="text-muted mb-4"><%= product.getDescription() %></p>

                <form action="cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    
                    <% if (variants != null && !variants.isEmpty()) { %>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Select Size &amp; Color Variant</label>
                            <select name="variantId" class="form-select" required>
                                <% for (ProductVariant v : variants) { %>
                                    <option value="<%= v.getVariantId() %>" <%= v.getStockQuantity() <= 0 ? "disabled" : "" %>>
                                        <%= v.getSize() %> / <%= v.getColor() %> - ₹<%= v.getPrice() %> 
                                        <%= v.getStockQuantity() <= 0 ? "(Out of Stock)" : "(" + v.getStockQuantity() + " available)" %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                    <% } else { %>
                        <!-- Dynamic Fallback: Passes Product ID as Variant ID if variants attribute is empty -->
                        <input type="hidden" name="variantId" value="<%= product.getProductId() %>">
                    <% } %>

                    <div class="mb-4">
                        <label class="form-label fw-bold">Quantity</label>
                        <input type="number" name="quantity" class="form-control" value="1" min="1" max="10" style="max-width: 120px;" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100">
                        <i class="fa-solid fa-cart-plus me-2"></i>Add to Cart
                    </button>
                </form>
            </div>
        </div>
    <% } else { %>
        <div class="text-center py-5">
            <h3>Product not found!</h3>
            <a href="products" class="btn btn-primary mt-3">Back to Store</a>
        </div>
    <% } %>
</div>

<jsp:include page="footer.jsp" />