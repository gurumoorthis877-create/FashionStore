package com.FashionStore.dao;

import com.FashionStore.model.Cart;

public interface CartDAO {
    boolean createCart(int userId);
    Cart getCartByUserId(int userId);
    boolean clearCart(int cartId);
}