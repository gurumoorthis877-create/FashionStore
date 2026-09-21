package com.FashionStore.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {

    private int productId;
    private String name;
    private String description;
    private int categoryId;
    private BigDecimal basePrice;
    private String imageUrl;
    private Timestamp createdAt;

    public Product() {}

    public Product(int productId, String name, String description, int categoryId, BigDecimal basePrice, String imageUrl, Timestamp createdAt) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.categoryId = categoryId;
        this.basePrice = basePrice;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    // Support getter/setter for productName for backwards compatibility across DAOs
    public String getProductName() { return name; }
    public void setProductName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}