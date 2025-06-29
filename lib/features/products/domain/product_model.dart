import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;

  Product({required this.id, required this.name, required this.price});
}
