import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/theme/app_themes.dart';
import 'package:learn_riverpod2/core/theme/theme_provider.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/home_screens.dart';

class ShoplyApp extends ConsumerWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: "Shoply (Riverpod)",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mode,
      home: HomeScreen(),
    );
  }
}
