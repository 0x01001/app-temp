import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class AuthState extends BaseState {}

final authProvider = StateNotifierProvider.autoDispose<AuthProvider, AppState<AuthState>>((ref) => AuthProvider(ref));

class AuthProvider extends BaseProvider<AuthState> {
  AuthProvider(this._ref) : super(AppState(data: AuthState()));

  final Ref _ref;

  Future<bool?> login(String email, String password) async {
    return await runSafe(action: () async {
      final response = await _ref.api.login(email, password);
      if (response != null) await _saveTokenAndUser(response);
      return response != null;
    });
  }

  Future<void> logout() async {
    return await runSafe(action: () => _ref.api.logout());
  }

  // Future<bool?> autoRefreshToken() async {
  //   return await runSafe(action: () => userRepository.autoRefreshToken());
  // }

  Future<bool?> register(String email, String password, String name) async {
    return await runSafe(action: () async {
      final response = await _ref.api.register(email, password, name);
      if (response != null) await _saveTokenAndUser(response);
      return response != null;
    });
  }

  Future<bool?> checkEmail(String email) async {
    return await runSafe(
      action: () async {
        final response = await _ref.api.checkEmail(email);
        return response?.registered ?? false;
      },
      handleLoading: false,
    );
  }

  Future<List<dynamic>> _saveTokenAndUser(AuthModel data) async {
    Log.d('_saveTokenAndUser: ${data.toJson()}');
    return Future.wait([
      // _ref.appPreferences.saveCurrentUser(data),
      if (!data.accessToken.isNullOrEmpty) _ref.appPreferences.saveAccessToken(data.accessToken!),
      if (!data.refreshToken.isNullOrEmpty) _ref.appPreferences.saveRefreshToken(data.refreshToken!),
    ]);
  }
}
