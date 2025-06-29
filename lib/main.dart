import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_riverpod2/app.dart';
import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
import 'package:learn_riverpod2/features/products/domain/order_model.dart';
import 'package:learn_riverpod2/features/products/domain/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(OrderAdapter());

  await Hive.openBox<CartItem>('cartBox');
  await Hive.openBox<Order>('orderBox');

  runApp(ProviderScope(child: ShoplyApp()));
}
