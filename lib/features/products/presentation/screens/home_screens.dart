import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/products/application/bottom_nav_provider.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/cart_screen.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/order_screen.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/product_list_screen.dart';
import 'package:learn_riverpod2/features/settings/presentation/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    final pages = const [ProductListScreen(), CartScreen(), OrderScreen(), SettingsScreen()];

    return Scaffold(

      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavProvider.notifier).state = index;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
