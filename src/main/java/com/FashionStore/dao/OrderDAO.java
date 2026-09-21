package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.Order;

public interface OrderDAO {
    int createOrder(Order order);
    Order getOrderById(int orderId);
    List<Order> getOrdersByUserId(int userId);
    List<Order> getAllOrders();
    boolean updateOrderStatus(int orderId, String status);
}