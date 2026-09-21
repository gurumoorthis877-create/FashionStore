<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Product" %>
<%@ page import="com.FashionStore.model.Category" %>
<jsp:include page="header.jsp" />

<%
    Product product = (Product) request.getAttribute("product");
    @SuppressWarnings("unchecked")
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    boolean isEdit = (product != null);
%>

<div class="container my-5" style="max-width: 700px;">
    <div class="card border-0 shadow-sm">
        <div class="card-body p-4">
            <h3 class="fw-bold mb-4">
                <i class="fa-solid <%= isEdit ? "fa-pen-to-square" : "fa-plus" %> me-2"></i>
                <%= isEdit ? "Edit Product" : "Add New Product" %>
            </h3>

            <form action="admin" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "updateProduct" : "insertProduct" %>">
                <% if (isEdit) { %>
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                <% } %>

                <!-- Product Name -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Product Name</label>
                    <input type="text" name="name" class="form-control" value="<%= isEdit ? product.getProductName() : "" %>" required placeholder="e.g., Kids Denim Jacket">
                </div>

                <!-- Category Selection -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="">-- Select Category --</option>
                        <% 
                            if (categories != null && !categories.isEmpty()) {
                                for (Category c : categories) {
                                    boolean selected = isEdit && c.getCategoryId() == product.getCategoryId();
                        %>
                            <option value="<%= c.getCategoryId() %>" <%= selected ? "selected" : "" %>>
                                <%= c.getCategoryName() %>
                            </option>
                        <% 
                                }
                            } else {
                        %>
                            <!-- Fallback category options -->
                            <option value="1" <%= isEdit && product.getCategoryId() == 1 ? "selected" : "" %>>Accessories</option>
                            <option value="2" <%= isEdit && product.getCategoryId() == 2 ? "selected" : "" %>>Men</option>
                            <option value="3" <%= isEdit && product.getCategoryId() == 3 ? "selected" : "" %>>Women</option>
                            <option value="4" <%= isEdit && product.getCategoryId() == 4 ? "selected" : "" %>>Kids</option>
                            <option value="5" <%= isEdit && product.getCategoryId() == 5 ? "selected" : "" %>>Gifts &amp; Offers</option>
                        <% } %>
                    </select>
                </div>

                <!-- Base Price (In Rupees) -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Base Price (₹)</label>
                    <input type="number" step="0.01" name="basePrice" class="form-control" value="<%= isEdit ? product.getBasePrice() : "" %>" required placeholder="0.00">
                </div>

                <!-- Image URL -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Image URL</label>
                    <input type="url" name="imageUrl" class="form-control" value="<%= isEdit && product.getImageUrl() != null ? product.getImageUrl() : "" %>" placeholder="https://example.com/image.jpg">
                </div>

                <!-- Description -->
                <div class="mb-4">
                    <label class="form-label fw-bold">Description</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Provide product details..."><%= isEdit && product.getDescription() != null ? product.getDescription() : "" %></textarea>
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex justify-content-between">
                    <a href="admin" class="btn btn-outline-secondary px-4">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4"><%= isEdit ? "Update Product" : "Save Product" %></button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />