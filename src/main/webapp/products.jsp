<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Product" %>
<%@ page import="com.FashionStore.model.Category" %>
<jsp:include page="header.jsp" />

<div class="hero-banner text-center mb-5 bg-light py-5">
    <div class="container">
        <h1 class="display-4 fw-bold">Explore Our Collections</h1>
        <p class="lead text-muted">Discover top fashion trends curated just for you.</p>
    </div>
</div>

<div class="container my-4">
    <div class="row">
        <!-- Sidebar Categories -->
        <div class="col-md-3 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-dark text-white fw-bold">
                    <i class="fa-solid fa-list me-2"></i> Categories
                </div>
                <div class="list-group list-group-flush">
                    <a href="products" class="list-group-item list-group-item-action fw-bold">All Categories</a>
                    <% 
                        @SuppressWarnings("unchecked")
                        List<Category> categories = (List<Category>) request.getAttribute("categoryList");
                        if (categories != null && !categories.isEmpty()) {
                            for (Category cat : categories) {
                    %>
                        <a href="products?action=category&categoryId=<%= cat.getCategoryId() %>" class="list-group-item list-group-item-action">
                            <i class="fa-solid fa-angle-right me-2 text-muted"></i><%= cat.getCategoryName() %>
                        </a>
                    <% 
                            }
                        } else {
                    %>
                        <a href="products?action=category&categoryId=1" class="list-group-item list-group-item-action"><i class="fa-solid fa-angle-right me-2 text-muted"></i>Accessories</a>
                        <a href="products?action=category&categoryId=2" class="list-group-item list-group-item-action"><i class="fa-solid fa-angle-right me-2 text-muted"></i>Men</a>
                        <a href="products?action=category&categoryId=3" class="list-group-item list-group-item-action"><i class="fa-solid fa-angle-right me-2 text-muted"></i>Women</a>
                        <a href="products?action=category&categoryId=4" class="list-group-item list-group-item-action"><i class="fa-solid fa-child me-2 text-primary"></i>Kids</a>
                        <a href="products?action=category&categoryId=5" class="list-group-item list-group-item-action"><i class="fa-solid fa-gift me-2 text-danger"></i>Gifts &amp; Offers</a>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="col-md-9">
            <h4 class="mb-4 fw-bold">All Products</h4>

            <div class="row g-4">
                <% 
                    @SuppressWarnings("unchecked")
                    List<Product> products = (List<Product>) request.getAttribute("productList");
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                            String rawImg = p.getImageUrl();
                            String finalImgUrl;
                            
                            if (rawImg != null && !rawImg.trim().isEmpty()) {
                                if (rawImg.startsWith("http://") || rawImg.startsWith("https://")) {
                                    finalImgUrl = rawImg.trim();
                                } else {
                                    String relativePath = rawImg.trim().startsWith("/") ? rawImg.trim() : "/" + rawImg.trim();
                                    finalImgUrl = request.getContextPath() + relativePath;
                                }
                            } else {
                                finalImgUrl = "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500";
                            }
                %>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="<%= finalImgUrl %>" 
                                 class="card-img-top" 
                                 alt="<%= p.getProductName() %>" 
                                 style="height: 250px; object-fit: cover;"
                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500';">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title text-truncate"><%= p.getProductName() %></h5>
                                <p class="card-text text-muted small flex-grow-1"><%= p.getDescription() %></p>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fw-bold text-primary fs-5">₹<%= p.getBasePrice() %></span>
                                    <a href="products?action=detail&id=<%= p.getProductId() %>" class="btn btn-outline-dark btn-sm">View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% 
                        }
                    } else { 
                %>
                    <div class="col-12 text-center py-5">
                        <p class="text-muted fs-5">No products found matching your criteria.</p>
                        <a href="products" class="btn btn-primary">Browse All Products</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />