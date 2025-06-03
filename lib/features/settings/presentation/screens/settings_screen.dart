import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Sozlamalar')),
      body: ListTile(
        title: Text('Tungi holat'),
        trailing: Switch(
          value: themeMode == ThemeMode.dark,
          onChanged: (isDark) {
            ref.read(themeModeProvider.notifier).state = isDark ? ThemeMode.dark : ThemeMode.light;
          },
        ),
      ),
    );
  }
}
