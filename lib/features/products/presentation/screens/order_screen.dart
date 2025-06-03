import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/application/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Buyurtmalar')),
      body: orderState.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Xatolik:: $error')),
        data:
            (orders) =>
                orders.isEmpty
                    ? Center(child: Text('Buyurtmalar y\'oq'))
                    : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return ListTile(
                          title: Text(
                            'Buyurtma #${index + 1} - \$${order.total.toStringAsFixed(2)}',
                          ),
                          subtitle: Text(order.date.toLocal().toString()),
                          onTap: () {},
                        );
                      },
                    ),
      ),
    );
  }
}
