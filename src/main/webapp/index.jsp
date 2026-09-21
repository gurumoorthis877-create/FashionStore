<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<div class="hero-banner text-center">
    <div class="container">
        <h1 class="display-3 fw-bold">Welcome to FashionStore</h1>
        <p class="lead mb-4">Discover trends, exclusive styles, and premium quality fashion.</p>
        <a href="products" class="btn btn-light btn-lg px-4 me-2"><i class="fa-solid fa-bag-shopping me-2"></i>Start Shopping</a>
    </div>
</div>

<div class="container my-5">
    <div class="row text-center g-4">
        <div class="col-md-4">
            <div class="p-4 border rounded shadow-sm bg-white">
                <i class="fa-solid fa-truck-fast fs-1 text-primary mb-3"></i>
                <h4>Fast Shipping</h4>
                <p class="text-muted">Get your orders delivered right to your doorstep quickly.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-4 border rounded shadow-sm bg-white">
                <i class="fa-solid fa-shield-halved fs-1 text-primary mb-3"></i>
                <h4>Secure Payments</h4>
                <p class="text-muted">Multiple safe payment options for hassle-free checkout.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="p-4 border rounded shadow-sm bg-white">
                <i class="fa-solid fa-rotate-left fs-1 text-primary mb-3"></i>
                <h4>Easy Returns</h4>
                <p class="text-muted">Simple return policies to guarantee complete satisfaction.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />