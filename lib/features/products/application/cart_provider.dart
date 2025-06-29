import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/providers/providers.dart';
import 'package:learn_riverpod2/core/services/local_db_service.dart';

import 'package:learn_riverpod2/features/products/domain/cart_item_model.dart';
import 'package:learn_riverpod2/features/products/domain/product_model.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  late final LocalDBService _db;
  final _boxName = 'cartBox';
  @override
  List<CartItem> build() {
    _db = ref.read(dbServiceProvider);
    final cached = _db.getAll<CartItem>(_boxName);

    return cached;
  }

  void _sync() {
    _db.saveAll<CartItem>(_boxName, state);
  }

  void addToCart(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      final updated = state[index].copyWith(quantity: state[index].quantity + 1);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updated else state[i],
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
    _sync();
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
    _sync();
  }

  void clearCart() {
    state = [];
    _db.clear<CartItem>(_boxName);
  }

  double get totalPirce => state.fold(0.0, (sum, item) => sum + item.total);
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

class FakeCartNotifier extends CartNotifier {
  FakeCartNotifier(this._items);

  final List<CartItem> _items;

  @override
  List<CartItem> build() => _items;
}
