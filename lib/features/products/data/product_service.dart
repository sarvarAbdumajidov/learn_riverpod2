import 'package:learn_riverpod2/features/products/domain/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return  [
      Product(id: 'p1', name: 'iPhone 15 Pro', price: 999.99),
      Product(id: 'p2', name: 'MacBook Air M2', price: 1199.99),
      Product(id: 'p3', name: 'AirPods Pro', price: 249.99),
    ];
  }
}
