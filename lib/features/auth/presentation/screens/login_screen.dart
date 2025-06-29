import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/auth/application/auth_provider.dart';
import 'package:learn_riverpod2/features/products/presentation/screens/home_screens.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:
            authState.isLoading
                ? Center(child: LinearProgressIndicator())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      onSubmitted: (name) async {
                        await ref.read(authProvider.notifier).login(name);
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        }
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Enter name'),
                    ),
                  ],
                ),
      ),
    );
  }
}
