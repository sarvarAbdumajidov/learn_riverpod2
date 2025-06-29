import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/features/auth/domain/user.model.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async => null;

  Future<void> login(String name) async {
    state = const AsyncValue.loading();
    await Future.delayed(Duration(seconds: 1));
    state = AsyncValue.data(User(id: name.hashCode.toString(), name: name));
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);
