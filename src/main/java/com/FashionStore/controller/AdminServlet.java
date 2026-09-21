package com.FashionStore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.FashionStore.dao.CategoryDAO;
import com.FashionStore.dao.OrderDAO;
import com.FashionStore.dao.ProductDAO;
import com.FashionStore.dao.ProductVariantDAO;
import com.FashionStore.dao.impl.CategoryDAOImpl;
import com.FashionStore.dao.impl.OrderDAOImpl;
import com.FashionStore.dao.impl.ProductDAOImpl;
import com.FashionStore.dao.impl.ProductVariantDAOImpl;
import com.FashionStore.model.Category;
import com.FashionStore.model.Order;
import com.FashionStore.model.Product;
import com.FashionStore.model.ProductVariant;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String ADMIN_PASSWORD = "admin";

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private ProductVariantDAO variantDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();
        variantDAO = new ProductVariantDAOImpl();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Handle Admin Logout
        if ("logout".equalsIgnoreCase(action)) {
            adminLogout(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        boolean isAuthenticated = (session != null && "true".equals(session.getAttribute("adminAuthenticated")));

        if (!isAuthenticated) {
            request.getRequestDispatcher("/admin/add-product.jsp").forward(request, response);
            return;
        }

        if (action == null || action.trim().isEmpty()) {
            action = "products";
        }

        switch (action) {
            case "categories":
                listCategories(request, response);
                break;
            case "products":
                listProducts(request, response);
                break;
            case "orders":
                listOrders(request, response);
                break;
            case "deleteProduct":
                deleteProduct(request, response);
                break;
            case "deleteCategory":
                deleteCategory(request, response);
                break;
            case "dashboard":
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("verifyAdminPassword".equalsIgnoreCase(action)) {
            verifyPassword(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        boolean isAuthenticated = (session != null && "true".equals(session.getAttribute("adminAuthenticated")));

        if (!isAuthenticated) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        switch (action) {
            case "addCategory":
                addCategory(request, response);
                break;
            case "addProduct":
                addProduct(request, response);
                break;
            case "addVariant":
                addVariant(request, response);
                break;
            case "updateOrderStatus":
                updateOrderStatus(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin");
                break;
        }
    }

    private void adminLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("adminAuthenticated");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    private void verifyPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inputPassword = request.getParameter("adminPassword");
        HttpSession session = request.getSession(true);

        if (ADMIN_PASSWORD.equals(inputPassword)) {
            session.setAttribute("adminAuthenticated", "true");
            response.sendRedirect(request.getContextPath() + "/admin?action=products");
        } else {
            request.setAttribute("error", "Invalid Admin Password!");
            request.getRequestDispatcher("/admin/add-product.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        List<Order> orders = orderDAO.getAllOrders();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("totalProducts", products.size());
        request.setAttribute("totalOrders", orders.size());
        request.setAttribute("totalCategories", categories.size());
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String categoryName = request.getParameter("categoryName");
        if (categoryName != null && !categoryName.trim().isEmpty()) {
            Category category = new Category();
            category.setCategoryName(categoryName.trim());
            categoryDAO.addCategory(category);
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=categories");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int categoryId = Integer.parseInt(idStr);
            categoryDAO.deleteCategory(categoryId);
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=categories");
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);
        request.getRequestDispatcher("/admin/add-product.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String catIdStr = request.getParameter("categoryId");
        String imageUrl = request.getParameter("imageUrl");

        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stockQuantity");

        if (name != null && catIdStr != null) {
            Product product = new Product();
            product.setProductName(name);
            product.setDescription(description);
            product.setCategoryId(Integer.parseInt(catIdStr));
            product.setImageUrl(imageUrl);
            if (priceStr != null) {
                product.setBasePrice(new BigDecimal(priceStr));
            }
            
            productDAO.addProduct(product);

            if (priceStr != null && stockStr != null) {
                List<Product> products = productDAO.getAllProducts();
                if (!products.isEmpty()) {
                    Product latestProduct = products.get(0); // Query uses ORDER BY product_id DESC
                    
                    ProductVariant variant = new ProductVariant();
                    variant.setProductId(latestProduct.getProductId());
                    variant.setSize(size);
                    variant.setColor(color);
                    variant.setPrice(new BigDecimal(priceStr));
                    variant.setStockQuantity(Integer.parseInt(stockStr));

                    variantDAO.addVariant(variant);
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int productId = Integer.parseInt(idStr);
            productDAO.deleteProduct(productId);
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=products");
    }

    private void addVariant(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String productIdStr = request.getParameter("productId");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String stockStr = request.getParameter("stockQuantity");
        String priceStr = request.getParameter("price");

        if (productIdStr != null && priceStr != null) {
            ProductVariant variant = new ProductVariant();
            variant.setProductId(Integer.parseInt(productIdStr));
            variant.setSize(size);
            variant.setColor(color);
            variant.setStockQuantity(Integer.parseInt(stockStr));
            variant.setPrice(new BigDecimal(priceStr));
            variantDAO.addVariant(variant);
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=products");
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orderList", orders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderIdStr != null && status != null) {
            int orderId = Integer.parseInt(orderIdStr);
            orderDAO.updateOrderStatus(orderId, status);
        }
        response.sendRedirect(request.getContextPath() + "/admin?action=orders");
    }
}