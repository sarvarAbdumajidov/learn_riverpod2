import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/application/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Orders'), centerTitle: true),
      body: orderState.when(
        loading: () => const Center(child: LinearProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (orders) =>
                orders.isEmpty
                    ? const Center(child: Text('No orders'))
                    : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (ctx, i) {
                        final order = orders[i];
                        return Card(
                          margin: const EdgeInsets.all(12),
                          child: ListTile(
                            title: Text(
                              'Order: \$${order.total.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Products: ${order.items.length}\n${order.date.toLocal()}',
                            ),
                          ),
                        );
                      },
                    ),
      ),
    );
  }
}
