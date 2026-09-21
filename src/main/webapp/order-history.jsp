<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.FashionStore.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:include page="header.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
%>

<div class="container my-5" style="min-height: 60vh;">
    <h2 class="mb-4"><i class="fa-solid fa-box-open me-2"></i>My Order History</h2>

    <% if (orders != null && !orders.isEmpty()) { %>
        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col" class="ps-4 py-3">Order ID</th>
                                <th scope="col" class="py-3">Date</th>
                                <th scope="col" class="py-3">Total Amount</th>
                                <th scope="col" class="py-3">Payment Method</th>
                                <th scope="col" class="pe-4 py-3">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Order o : orders) { %>
                                <tr>
                                    <td class="ps-4 fw-bold">#<%= o.getOrderId() %></td>
                                    <td><%= o.getCreatedAt() != null ? sdf.format(o.getCreatedAt()) : "N/A" %></td>
                                    <td class="fw-bold text-primary">$<%= o.getTotalAmount() %></td>
                                    <td><%= o.getPaymentMethod() %></td>
                                    <td class="pe-4">
                                        <% 
                                            String status = o.getOrderStatus() != null ? o.getOrderStatus().toUpperCase() : "UNKNOWN";
                                            String badgeClass = "bg-secondary";
                                            
                                            if ("PENDING".equals(status)) badgeClass = "bg-warning text-dark";
                                            else if ("PROCESSING".equals(status)) badgeClass = "bg-info text-dark";
                                            else if ("SHIPPED".equals(status)) badgeClass = "bg-primary";
                                            else if ("DELIVERED".equals(status)) badgeClass = "bg-success";
                                            else if ("CANCELLED".equals(status)) badgeClass = "bg-danger";
                                        %>
                                        <span class="badge <%= badgeClass %>"><%= status %></span>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <% } else { %>
        <div class="text-center py-5">
            <i class="fa-solid fa-receipt fs-1 text-muted mb-3"></i>
            <h4>No Orders Found</h4>
            <p class="text-muted">You haven't placed any orders yet.</p>
            <a href="products" class="btn btn-primary mt-2">Start Shopping</a>
        </div>
    <% } %>
</div>

<jsp:include page="footer.jsp" />