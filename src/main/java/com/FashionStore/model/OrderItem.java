package com.FashionStore.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int variantId;
    private int quantity;
    private BigDecimal price;
    private Timestamp createdAt;

    public OrderItem() {}

    public OrderItem(int orderItemId, int orderId, int variantId, int quantity, BigDecimal price, Timestamp createdAt) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.variantId = variantId;
        this.quantity = quantity;
        this.price = price;
        this.createdAt = createdAt;
    }

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}