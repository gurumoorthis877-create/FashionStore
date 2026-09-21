package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.CartItem;

public interface CartItemDAO {
    boolean addCartItem(CartItem item);
    boolean updateQuantity(int cartItemId, int quantity);
    boolean removeCartItem(int cartItemId);
    boolean clearCart(int cartId);
    List<CartItem> getItemsByCartId(int cartId);
    CartItem getCartItem(int cartId, int variantId);
}