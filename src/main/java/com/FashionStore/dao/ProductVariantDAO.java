package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.ProductVariant;

public interface ProductVariantDAO {

    boolean addVariant(ProductVariant variant);

    boolean updateVariant(ProductVariant variant);

    boolean deleteVariant(int variantId);

    ProductVariant getVariantById(int variantId);

    List<ProductVariant> getVariantsByProductId(int productId);

    boolean updateStock(int variantId, int newQuantity);
}