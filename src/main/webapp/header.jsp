<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.FashionStore.model.User" %>
<%
    // Prevent browser HTTP caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionStore</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">

    <!-- Prevents Back/Undo button from displaying cached logged-in state after logout -->
    <script type="text/javascript">
        window.addEventListener("pageshow", function (event) {
            var historyTraversal = event.persisted || 
                (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
            if (historyTraversal) {
                window.location.reload();
            }
        });
    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="products"><i class="fa-solid fa-shirt me-2"></i>FashionStore</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="products">Shop All</a></li>
      </ul>
      <form class="d-flex me-3" action="products" method="get">
        <input type="hidden" name="action" value="search">
        <input class="form-control me-2" type="search" name="query" placeholder="Search products..." aria-label="Search">
        <button class="btn btn-outline-light" type="submit">Search</button>
      </form>
      <ul class="navbar-nav">
        <% if (currentUser == null) { %>
            <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
            <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
        <% } else { %>
            <li class="nav-item"><a class="nav-link" href="cart"><i class="fa-solid fa-cart-shopping me-1"></i>Cart</a></li>
            <li class="nav-item"><a class="nav-link" href="order?action=history">My Orders</a></li>
            <% if ("ADMIN".equalsIgnoreCase(currentUser.getRole())) { %>
                <li class="nav-item"><a class="nav-link text-warning" href="admin">Admin Portal</a></li>
            <% } %>
            <li class="nav-item"><a class="nav-link text-danger" href="logout">Logout (<%= currentUser.getFullName() %>)</a></li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>