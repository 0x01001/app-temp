import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/index.dart';
import '../../../index.dart';

part 'provider.g.dart';

@Riverpod()
class Auth extends _$Auth with Base {
  @override
  Future<void> build() async {
    Log.d('LoginProvider > build');
  }

  Future<bool?> login(String email, String password) async {
    return await runSafe(action: () => userRepository.login(email, password));
  }

  Future<void> logout() async {
    return await runSafe(action: () => userRepository.logout());
  }

  // Future<bool?> autoRefreshToken() async {
  //   return await runSafe(action: () => userRepository.autoRefreshToken());
  // }

  Future<bool?> register(String email, String password, String name) async {
    return await runSafe(action: () => userRepository.register(email, password, name));
  }

  Future<bool?> checkEmail(String email) async {
    return await runSafe(
      action: () => userRepository.checkEmail(email),
      handleLoading: false,
    );
  }
}
