package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.OrderItem;

public interface OrderItemDAO {
    boolean addOrderItem(OrderItem item);
    List<OrderItem> getItemsByOrderId(int orderId);
}