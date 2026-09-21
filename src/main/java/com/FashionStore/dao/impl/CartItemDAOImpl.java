package com.FashionStore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.FashionStore.dao.CartItemDAO;
import com.FashionStore.model.CartItem;
import com.FashionStore.util.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    @Override
    public boolean addCartItem(CartItem item) {
        String sql = "INSERT INTO cart_items (cart_id, variant_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getCartId());
            stmt.setInt(2, item.getVariantId());
            stmt.setInt(3, item.getQuantity());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeCartItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean clearCart(int cartId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<CartItem> getItemsByCartId(int cartId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.variant_id, ci.quantity, ci.created_at, " +
                     "COALESCE(p.product_name, 'Fashion Item') AS product_name, " +
                     "p.image_url, " +
                     "COALESCE(pv.price, p.base_price, 0.0) AS unit_price, " +
                     "CONCAT(COALESCE(pv.size, 'Standard'), ' / ', COALESCE(pv.color, 'Default')) AS variant_details " +
                     "FROM cart_items ci " +
                     "LEFT JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
                     "LEFT JOIN products p ON pv.product_id = p.product_id OR ci.variant_id = p.product_id " +
                     "WHERE ci.cart_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = extractCartItem(rs);
                    item.setProductName(rs.getString("product_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setVariantDetails(rs.getString("variant_details"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public CartItem getCartItem(int cartId, int variantId) {
        String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.variant_id, ci.quantity, ci.created_at, " +
                     "COALESCE(p.product_name, 'Fashion Item') AS product_name, " +
                     "p.image_url, " +
                     "COALESCE(pv.price, p.base_price, 0.0) AS unit_price, " +
                     "CONCAT(COALESCE(pv.size, 'Standard'), ' / ', COALESCE(pv.color, 'Default')) AS variant_details " +
                     "FROM cart_items ci " +
                     "LEFT JOIN product_variants pv ON ci.variant_id = pv.variant_id " +
                     "LEFT JOIN products p ON pv.product_id = p.product_id OR ci.variant_id = p.product_id " +
                     "WHERE ci.cart_id = ? AND ci.variant_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, variantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    CartItem item = extractCartItem(rs);
                    item.setProductName(rs.getString("product_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    item.setVariantDetails(rs.getString("variant_details"));
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private CartItem extractCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setCartItemId(rs.getInt("cart_item_id"));
        item.setCartId(rs.getInt("cart_id"));
        item.setVariantId(rs.getInt("variant_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        return item;
    }
}