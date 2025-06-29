import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/theme/app_themes.dart';
import 'package:learn_riverpod2/core/theme/theme_provider.dart';
import 'package:learn_riverpod2/features/auth/application/auth_provider.dart';
import 'package:learn_riverpod2/features/auth/presentation/screens/login_screen.dart';
import 'package:learn_riverpod2/features/products/application/cart_provider.dart';
import 'package:learn_riverpod2/features/products/application/order_provider.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/home_screens.dart';

class ShoplyApp extends ConsumerWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final auth = ref.watch(authProvider);
    ref.listen(authProvider, (previous, next) {
      if (next.value == null) {
        ref.read(cartProvider.notifier).clearCart();
        ref.invalidate(orderProvider);
      }
    });
    return MaterialApp(
      title: "Shoply (Riverpod)",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mode,
      home: auth.when(
        loading: () => const Scaffold(body: Center(child: LinearProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('Xato: $e'))),
        data: (user) => user == null ? const LoginScreen() : const HomeScreen(),
      ),
    );
  }
}
