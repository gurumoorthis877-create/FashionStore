package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.Product;

public interface ProductDAO {

    boolean addProduct(Product product);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);

    Product getProductById(int productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategoryId(int categoryId);

    List<Product> searchProductsByName(String keyword);
}