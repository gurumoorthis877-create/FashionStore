package com.FashionStore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.FashionStore.dao.ProductVariantDAO;
import com.FashionStore.model.ProductVariant;
import com.FashionStore.util.DBConnection;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public boolean addVariant(ProductVariant variant) {
        String sql = "INSERT INTO product_variants (product_id, size, color, stock_quantity, price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, variant.getProductId());
            stmt.setString(2, variant.getSize());
            stmt.setString(3, variant.getColor());
            stmt.setInt(4, variant.getStockQuantity());
            stmt.setBigDecimal(5, variant.getPrice());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateVariant(ProductVariant variant) {
        String sql = "UPDATE product_variants SET size = ?, color = ?, stock_quantity = ?, price = ? WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, variant.getSize());
            stmt.setString(2, variant.getColor());
            stmt.setInt(3, variant.getStockQuantity());
            stmt.setBigDecimal(4, variant.getPrice());
            stmt.setInt(5, variant.getVariantId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteVariant(int variantId) {
        String sql = "DELETE FROM product_variants WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, variantId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ProductVariant getVariantById(int variantId) {
        String sql = "SELECT * FROM product_variants WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, variantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractVariantFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {
        List<ProductVariant> variantList = new ArrayList<>();
        String sql = "SELECT * FROM product_variants WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    variantList.add(extractVariantFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variantList;
    }

    @Override
    public boolean updateStock(int variantId, int newQuantity) {
        String sql = "UPDATE product_variants SET stock_quantity = ? WHERE variant_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, variantId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private ProductVariant extractVariantFromResultSet(ResultSet rs) throws SQLException {
        ProductVariant variant = new ProductVariant();
        variant.setVariantId(rs.getInt("variant_id"));
        variant.setProductId(rs.getInt("product_id"));
        variant.setSize(rs.getString("size"));
        variant.setColor(rs.getString("color"));
        variant.setStockQuantity(rs.getInt("stock_quantity"));
        variant.setPrice(rs.getBigDecimal("price"));
        variant.setCreatedAt(rs.getTimestamp("created_at"));
        return variant;
    }
}