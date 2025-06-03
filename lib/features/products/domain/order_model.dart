import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime date;

  const Order({required this.id, required this.items, required this.date});

  double get total => items.fold(0.0, (sum, item) => sum + item.total);
}
