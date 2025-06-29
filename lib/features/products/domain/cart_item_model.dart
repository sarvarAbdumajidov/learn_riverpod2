import 'package:hive/hive.dart';
import 'package:learn_riverpod2/features/products/domain/product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  final Product product;
  @HiveField(1)
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  double get total => product.price * quantity;
}
