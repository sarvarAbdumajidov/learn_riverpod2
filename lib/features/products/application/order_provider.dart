import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/providers/providers.dart';

import 'package:uuid/uuid.dart';

import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
import 'package:learn_riverpod2/features/products/domain/order_model.dart';
import 'package:learn_riverpod2/core/services/local_db_service.dart';

class OrderNotifier extends AsyncNotifier<List<Order>> {
  late final LocalDBService _db;
  final _boxName = 'orderBox';
  @override
  FutureOr<List<Order>> build() {
    _db = ref.read(dbServiceProvider);
    final cached = _db.getAll<Order>(_boxName);
    return cached;
  }

  void _sync(List<Order> orders) {
    _db.saveAll<Order>(_boxName, orders);
    state = AsyncValue.data(orders);
  }

  void placeOrder(List<CartItem> cartItems) {
    final orders = state.value ?? [];
    final newOrder = Order(
      id: const Uuid().v4(),
      items: List.from(cartItems),
      date: DateTime.now(),
    );
    final updateOrders = [...orders, newOrder];
    _sync(updateOrders);
  }
}

final orderProvider = AsyncNotifierProvider<OrderNotifier, List<Order>>(OrderNotifier.new);
