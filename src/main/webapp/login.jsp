<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<div class="container my-5" style="max-width: 450px;">
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <h3 class="card-title text-center mb-4 fw-bold">Welcome Back</h3>

            <%-- Error Message Banner --%>
            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div class="alert alert-danger mb-3 py-2 text-center" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-1"></i> <%= error %>
                </div>
            <% } %>

            <%-- Success Message Banner --%>
            <% String success = (String) request.getAttribute("successMessage"); %>
            <% if (success != null) { %>
                <div class="alert alert-success mb-3 py-2 text-center" role="alert">
                    <i class="fa-solid fa-circle-check me-1"></i> <%= success %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/auth" method="post">
                
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="admin@fashionstore.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mt-2">Log In</button>
            </form>

            <div class="text-center mt-3">
                <small class="text-muted">Don't have an account? <a href="register.jsp" class="fw-semibold text-decoration-none">Register here</a></small>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />