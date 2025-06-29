import 'package:hive/hive.dart';
import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
part 'order_model.g.dart';

@HiveType(typeId: 2)
class Order extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<CartItem> items;
  @HiveField(2)
  final DateTime date;

  Order({required this.id, required this.items, required this.date});

  double get total => items.fold(0.0, (sum, item) => sum + item.total);
}
