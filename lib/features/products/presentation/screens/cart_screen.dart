import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/application/cart_provider.dart';
import 'package:learn_riverpod2/features/products/application/order_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider); // 🔍 state kuzatilmoqda
    final cart = ref.read(cartProvider.notifier); // 🔧 actionlar uchun

    final total = cartItems.fold<double>(0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, i) {
                final item = cartItems[i];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${item.total.toStringAsFixed(2)}'),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          cart.removeFromCart(item.product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Total price: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed:
                      cartItems.isEmpty
                          ? null
                          : () {
                            ref.read(orderProvider.notifier).placeOrder(cartItems);
                            cart.clearCart();
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text('Order placed!')));
                          },
                  child: const Text('Place an order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
