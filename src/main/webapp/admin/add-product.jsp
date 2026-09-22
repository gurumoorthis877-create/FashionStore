<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Product" %>
<%@ page import="com.FashionStore.model.Category" %>
<jsp:include page="../header.jsp" />

<div class="container my-5">
    <% 
        String adminAuth = (String) session.getAttribute("adminAuthenticated");
        if (adminAuth == null || !"true".equals(adminAuth)) {
    %>
        <!-- Admin Password Form -->
        <div class="card mx-auto shadow-sm" style="max-width: 450px;">
            <div class="card-header bg-dark text-white fw-bold text-center">
                <i class="fa-solid fa-lock me-2"></i>Admin Verification Required
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="verifyAdminPassword">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Enter Admin Passcode</label>
                        <input type="password" name="adminPassword" class="form-control" placeholder="Enter password..." required>
                    </div>
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger py-2 mb-3"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <button type="submit" class="btn btn-dark w-100 fw-bold">Unlock Admin Panel</button>
                </form>
            </div>
        </div>
    <% } else { %>
        <!-- Admin Header & Logout Button -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold m-0">Admin Product Management</h3>
            <a href="${pageContext.request.contextPath}/admin?action=logout" class="btn btn-outline-danger fw-bold">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Admin Logout
            </a>
        </div>

        <!-- Add Product & Variant Form -->
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white fw-bold">
                        <i class="fa-solid fa-plus me-2"></i>Add New Product and Variant
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/admin" method="post">
                            <input type="hidden" name="action" value="addProduct">

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Category</label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">-- Select Category --</option>
                                    <% 
                                        @SuppressWarnings("unchecked")
                                        List<Category> categories = (List<Category>) request.getAttribute("categoryList");
                                        if (categories != null && !categories.isEmpty()) {
                                            for (Category c : categories) {
                                    %>
                                                <option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
                                    <% 
                                            }
                                        } 
                                    %>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Product Name</label>
                                <input type="text" name="name" class="form-control" placeholder="e.g. Cotton Casual Shirt" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Product Details / Description</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Enter product details..." required></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Image Path / Web URL</label>
                                <input type="text" name="imageUrl" class="form-control" placeholder="images/shirt.jpg or URL" required>
                            </div>

                            <hr class="my-4">
                            <h6 class="fw-bold mb-3"><i class="fa-solid fa-tags me-1"></i>Initial Variant Information</h6>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Size (Select or Type Custom)</label>
                                    <input type="text" name="size" class="form-control" list="sizeOptions" placeholder="Type or select size..." required autocomplete="off">
                                    <datalist id="sizeOptions">
                                        <option value="ALL"></option>
                                        <option value="Free Size"></option>
                                        <option value="S"></option>
                                        <option value="M"></option>
                                        <option value="L"></option>
                                        <option value="XL"></option>
                                        <option value="XXL"></option>
                                    </datalist>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Color</label>
                                    <input type="text" name="color" class="form-control" placeholder="e.g. Black / Blue" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Price (INR)</label>
                                    <input type="number" step="0.01" name="price" class="form-control" placeholder="1299.00" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Stock Quantity</label>
                                    <input type="number" name="stockQuantity" class="form-control" placeholder="50" required>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 fw-bold mt-2">Save Product and Variant</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Existing Products List -->
            <div class="col-md-6">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white fw-bold">
                        <i class="fa-solid fa-list me-2"></i>Existing Products
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Category ID</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        @SuppressWarnings("unchecked")
                                        List<Product> products = (List<Product>) request.getAttribute("productList");
                                        if (products != null && !products.isEmpty()) {
                                            for (Product p : products) {
                                    %>
                                                <tr>
                                                    <td>#<%= p.getProductId() %></td>
                                                    <td><strong><%= p.getProductName() %></strong></td>
                                                    <td><%= p.getCategoryId() %></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/admin?action=deleteProduct&id=<%= p.getProductId() %>" class="btn btn-sm btn-outline-danger">Delete</a>
                                                    </td>
                                                </tr>
                                    <% 
                                            }
                                        } else {
                                    %>
                                            <tr>
                                                <td colspan="4" class="text-center py-3 text-muted">No products found.</td>
                                            </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<jsp:include page="../footer.jsp" />