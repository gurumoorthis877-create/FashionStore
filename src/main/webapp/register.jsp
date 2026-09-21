<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<div class="container my-5" style="max-width: 550px;">
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <h3 class="card-title text-center mb-4">Create Account</h3>

            <% String error = (String) request.getAttribute("errorMessage"); %>
            <% if (error != null) { %>
                <div class="alert alert-danger mb-3"><%= error %></div>
            <% } %>

            <form action="auth" method="post">
                <input type="hidden" name="action" value="register">
                
                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select" required>
                            <option value="Unspecified">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Shipping Address</label>
                    <textarea name="address" class="form-control" rows="2" required></textarea>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2">Create Account</button>
            </form>

            <div class="text-center mt-3">
                <small class="text-muted">Already have an account? <a href="login.jsp">Log In</a></small>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />