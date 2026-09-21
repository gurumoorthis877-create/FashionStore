package com.FashionStore.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.FashionStore.dao.CategoryDAO;
import com.FashionStore.dao.ProductDAO;
import com.FashionStore.dao.ProductVariantDAO;
import com.FashionStore.dao.impl.CategoryDAOImpl;
import com.FashionStore.dao.impl.ProductDAOImpl;
import com.FashionStore.dao.impl.ProductVariantDAOImpl;
import com.FashionStore.model.Category;
import com.FashionStore.model.Product;
import com.FashionStore.model.ProductVariant;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private ProductVariantDAO variantDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();
        variantDAO = new ProductVariantDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "detail":
                showProductDetail(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            case "category":
                filterByCategory(request, response);
                break;
            case "list":
            default:
                listAllProducts(request, response);
                break;
        }
    }

    private void listAllProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("productList", products);
        request.setAttribute("categoryList", categories);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    private void filterByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String catIdParam = request.getParameter("categoryId");
        if (catIdParam != null && !catIdParam.trim().isEmpty()) {
            int categoryId = Integer.parseInt(catIdParam);
            List<Product> products = productDAO.getProductsByCategoryId(categoryId);
            List<Category> categories = categoryDAO.getAllCategories();
            Category selectedCategory = categoryDAO.getCategoryById(categoryId);

            request.setAttribute("productList", products);
            request.setAttribute("categoryList", categories);
            request.setAttribute("selectedCategory", selectedCategory);
            request.getRequestDispatcher("products.jsp").forward(request, response);
        } else {
            listAllProducts(request, response);
        }
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        if (query != null && !query.trim().isEmpty()) {
            List<Product> products = productDAO.searchProductsByName(query.trim());
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("productList", products);
            request.setAttribute("categoryList", categories);
            request.setAttribute("searchQuery", query);
            request.getRequestDispatcher("products.jsp").forward(request, response);
        } else {
            listAllProducts(request, response);
        }
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            int productId = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId);
                Category category = categoryDAO.getCategoryById(product.getCategoryId());

                request.setAttribute("product", product);
                request.setAttribute("variants", variants);
                request.setAttribute("category", category);
                request.getRequestDispatcher("product-detail.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("products");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}