<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Product" %>
<%@ page import="com.FashionStore.model.Category" %>
<%@ page import="com.FashionStore.model.Order" %>
<jsp:include page="header.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("productList");
    @SuppressWarnings("unchecked")
    List<Category> categories = (List<Category>) request.getAttribute("categoryList");
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orderList");

    int totalProducts = products != null ? products.size() : 0;
    int totalCategories = categories != null ? categories.size() : 0;
    int totalOrders = orders != null ? orders.size() : 0;
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-user-gear me-2"></i>Admin Dashboard</h2>
        <a href="admin?action=addProduct" class="btn btn-primary"><i class="fa-solid fa-plus me-1"></i> Add New Product</a>
    </div>

    <!-- Stat Cards -->
    <div class="row g-3 mb-5">
        <div class="col-md-4">
            <div class="card bg-primary text-white border-0 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase mb-1 fs-6 opacity-75">Total Products</h6>
                        <h2 class="fw-bold mb-0"><%= totalProducts %></h2>
                    </div>
                    <i class="fa-solid fa-shirt fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white border-0 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase mb-1 fs-6 opacity-75">Categories</h6>
                        <h2 class="fw-bold mb-0"><%= totalCategories %></h2>
                    </div>
                    <i class="fa-solid fa-list fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-warning text-dark border-0 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase mb-1 fs-6 opacity-75">Total Orders</h6>
                        <h2 class="fw-bold mb-0"><%= totalOrders %></h2>
                    </div>
                    <i class="fa-solid fa-boxes-packing fa-3x opacity-50"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Management Tabs -->
    <ul class="nav nav-tabs mb-4" id="adminTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active fw-bold" id="products-tab" data-bs-toggle="tab" data-bs-target="#products-tab-pane" type="button" role="tab">Products</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-bold" id="orders-tab" data-bs-toggle="tab" data-bs-target="#orders-tab-pane" type="button" role="tab">Orders</button>
        </li>
    </ul>

    <div class="tab-content" id="adminTabContent">
        <!-- Products Table -->
        <div class="tab-pane fade show active" id="products-tab-pane" role="tabpanel" tabindex="0">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Base Price</th>
                                    <th class="text-end pe-4">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (products != null && !products.isEmpty()) {
                                    for (Product p : products) { %>
                                        <tr>
                                            <td class="ps-4"><%= p.getProductId() %></td>
                                            <td>
                                                <img src="<%= p.getImageUrl() != null && !p.getImageUrl().isEmpty() ? p.getImageUrl() : "https://via.placeholder.com/50?text=No+Img" %>" class="rounded" style="width: 40px; height: 40px; object-fit: cover;" alt="<%= p.getName() %>">
                                            </td>
                                            <td class="fw-bold"><%= p.getName() %></td>
                                            <td>$<%= p.getBasePrice() %></td>
                                            <td class="text-end pe-4">
                                                <a href="admin?action=editProduct&id=<%= p.getProductId() %>" class="btn btn-sm btn-outline-secondary me-1"><i class="fa-solid fa-pen"></i></a>
                                                <form action="admin" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="deleteProduct">
                                                    <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete this product?');"><i class="fa-solid fa-trash"></i></button>
                                                </form>
                                            </td>
                                        </tr>
                                <%  } 
                                   } else { %>
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">No products found.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="tab-pane fade" id="orders-tab-pane" role="tabpanel" tabindex="0">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">Order ID</th>
                                    <th>Total</th>
                                    <th>Payment</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Update Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (orders != null && !orders.isEmpty()) {
                                    for (Order o : orders) { %>
                                        <tr>
                                            <td class="ps-4 fw-bold">#<%= o.getOrderId() %></td>
                                            <td>$<%= o.getTotalAmount() %></td>
                                            <td><%= o.getPaymentMethod() %></td>
                                            <td><span class="badge bg-info text-dark"><%= o.getOrderStatus() %></span></td>
                                            <td class="text-end pe-4">
                                                <form action="admin" method="post" class="d-inline-flex align-items-center justify-content-end">
                                                    <input type="hidden" name="action" value="updateOrderStatus">
                                                    <input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
                                                    <select name="orderStatus" class="form-select form-select-sm me-2" style="width: auto;">
                                                        <option value="PENDING" <%= "PENDING".equalsIgnoreCase(o.getOrderStatus()) ? "selected" : "" %>>PENDING</option>
                                                        <option value="PROCESSING" <%= "PROCESSING".equalsIgnoreCase(o.getOrderStatus()) ? "selected" : "" %>>PROCESSING</option>
                                                        <option value="SHIPPED" <%= "SHIPPED".equalsIgnoreCase(o.getOrderStatus()) ? "selected" : "" %>>SHIPPED</option>
                                                        <option value="DELIVERED" <%= "DELIVERED".equalsIgnoreCase(o.getOrderStatus()) ? "selected" : "" %>>DELIVERED</option>
                                                        <option value="CANCELLED" <%= "CANCELLED".equalsIgnoreCase(o.getOrderStatus()) ? "selected" : "" %>>CANCELLED</option>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-primary">Save</button>
                                                </form>
                                            </td>
                                        </tr>
                                <%  } 
                                   } else { %>
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">No orders found.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />