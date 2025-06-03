import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
import 'package:learn_riverpod2/features/products/domain/order_model.dart';

class OrderNotifier extends AsyncNotifier<List<Order>> {
  @override
  FutureOr<List<Order>> build() async => [];

  void placeOrder(List<CartItem> cartItems) {
    final newOrder = Order(
      id: const Uuid().v4(),
      items: List.from(cartItems),
      date: DateTime.now(),
    );
    state = AsyncValue.data([...state.value ?? [], newOrder]);
  }
}

final orderProvider = AsyncNotifierProvider<OrderNotifier, List<Order>>(OrderNotifier.new);
