import 'package:cloud_firestore/cloud_firestore.dart';
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
      // final response = await _ref.api.login(email, password);
      // if (response != null) await _saveTokenAndUser(response);
      // return response != null;
      final userId = await _ref.firebaseAuth.signInWithEmailAndPassword(email, password);
      if (userId.isEmpty) return false;

      final user = await _ref.firebaseFirestore.getCurrentUser(userId);
      final deviceId = await _ref.device.id;
      if (user.deviceIds?.isNotEmpty == true && !user.deviceIds!.contains(deviceId)) {
        Log.d('ID: ${user.id} has logged in on new device ($deviceId)');
        // await _ref.firebaseAuth.signOut();
        // data = data.copyWith(onPageError: 'You have logged in on another device.');
        // return;
      }
      final deviceToken = await _ref.share.deviceToken;
      Log.d('Login > device token: $deviceToken');

      final data = user.copyWith(deviceIds: [...user.deviceIds ?? [], deviceId], deviceTokens: [...user.deviceTokens ?? [], deviceToken]);
      await _saveTokenAndUser(data);

      return true;
    });
  }

  Future<void> logout() async {
    // return await runSafe(action: () => _ref.api.logout());
    try {
      final deviceToken = await _ref.share.deviceToken;
      await _ref.firebaseFirestore.updateCurrentUser(userId: _ref.preferences.userId, data: {
        FirebaseUserModel.keyDeviceIds: [],
        FirebaseUserModel.keyDeviceTokens: FieldValue.arrayRemove([deviceToken]),
      });
      await _ref.preferences.clearCurrentUserData();
      await _ref.firebaseAuth.signOut();
      _ref.update<FirebaseUserModel>(currentUserProvider, (state) => FirebaseUserModel());
      await _ref.nav.replaceAll([const LoginRoute()]);
    } catch (e) {
      await _ref.nav.replaceAll([const LoginRoute()]);
    }
  }

  Future<void> deleteAccount() async {
    return runSafe(
      action: () async {
        await _ref.preferences.clearCurrentUserData();
        await _ref.firebaseFirestore.deleteUser(_ref.preferences.userId);
        await _ref.firebaseAuth.deleteAccount();
        await _ref.nav.replaceAll([const LoginRoute()]);
      },
      handleError: false,
      onError: (e) async {
        await _ref.nav.replaceAll([const LoginRoute()]);
      },
    );
  }

  // Future<bool?> autoRefreshToken() async {
  //   return await runSafe(action: () => userRepository.autoRefreshToken());
  // }

  Future<bool?> register(String email, String password, String name) async {
    return await runSafe(action: () async {
      // final response = await _ref.api.register(email, password, name);
      // if (response != null) await _saveTokenAndUser(response);
      // return response != null;

      final userId = await _ref.firebaseAuth.createUserWithEmailAndPassword(email, password);
      if (userId.isEmpty) return false;

      final deviceToken = await _ref.share.deviceToken;
      final deviceId = await _ref.device.id;
      Log.d('deviceToken: $deviceToken');
      final data = FirebaseUserModel(id: userId, email: email, isVip: false, deviceIds: [deviceId], deviceTokens: [deviceToken]);
      await _saveTokenAndUser(data, isUpdate: false);
      return true;
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

  Future<List<dynamic>> _saveTokenAndUser(FirebaseUserModel data, {bool? isUpdate = true}) async {
    Log.d('_saveTokenAndUser: ${data.toJson()}');
    return Future.wait([
      // _ref.appPreferences.saveCurrentUser(data),
      // if (!data.accessToken.isNullOrEmpty) _ref.preferences.saveAccessToken(data.accessToken!),
      // if (!data.refreshToken.isNullOrEmpty) _ref.preferences.saveRefreshToken(data.refreshToken!),
      _ref.preferences.saveIsLoggedIn(true),
      _ref.preferences.saveUserId(data.id ?? ''),
      _ref.preferences.saveEmail(data.email ?? ''),
      if (isUpdate == true) _ref.firebaseFirestore.updateCurrentUser(userId: data.id ?? '', data: data.toMap()),
      if (isUpdate == false) _ref.firebaseFirestore.putUserToFireStore(userId: data.id ?? '', data: data),
    ]);
  }
}
