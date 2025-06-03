import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/data/product_service.dart';
import 'package:learn_riverpod2/features/products/domain/product_model.dart';

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    final products = await ProductService().fetchProducts();
    return products;
  }
}

final productProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(
  ProductNotifier.new,
);
