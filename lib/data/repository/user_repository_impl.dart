// // import 'dart:async';

// import 'package:dartx/dartx.dart';
// import 'package:injectable/injectable.dart';

// import '../../domain/index.dart';
// import '../../shared/index.dart';
// import '../index.dart';

// @LazySingleton(as: UserRepository)
// class UserRepositoryImpl implements UserRepository {
//   UserRepositoryImpl(this._appApiService, this._appPreferences, this._appDatabase, this._appFirebaseAuth);

//   final AppApiService _appApiService;
//   final AppPreferences _appPreferences;
//   final AppDatabase _appDatabase;
//   final AppFirebaseAuth _appFirebaseAuth;

//   // @override
//   // Future<void> init() async {
//   //   await _appPreferences.init();
//   // }

//   @override
//   bool get isLoggedIn => Constant.isEnable ? _appFirebaseAuth.isLoggedIn : _appPreferences.isLoggedIn;

//   @override
//   Future<bool> register(String email, String password, String name) async {
//     AuthModel? response;
//     if (Constant.isEnable) {
//       response = await _appFirebaseAuth.register(email: email, password: password, name: name);
//     } else {
//       response = await _appApiService.register(
//         // username: username,
//         email: email,
//         password: password,
//         // gender: _genderDataMapper.mapToData(gender),
//       );
//     }
//     if (response != null) await _saveTokenAndUser(response);
//     return response != null;
//   }

//   @override
//   Future<bool> login(String email, String password) async {
//     AuthModel? response;
//     if (Constant.isEnable) {
//       response = await _appFirebaseAuth.login(email: email, password: password);
//     } else {
//       response = await _appApiService.login(email, password);
//     }
//     if (response != null) await _saveTokenAndUser(response);
//     return response != null;
//   }

//   // @override
//   // Future<bool> autoRefreshToken() async {
//   //   if (Constants.isEnable) {
//   //     return await _appFirebase.autoRefresh();
//   //   }
//   //   return false;
//   // }

//   @override
//   Future<void> logout() async {
//     if (Constant.isEnable) {
//       await _appFirebaseAuth.logout();
//     } else {
//       await _appApiService.logout();
//     }
//     await _appPreferences.clearCurrentUserData();
//   }

//   @override
//   Future<void> resetPassword({required String token, required String email, required String password, required String confirmPassword}) async {
//     await _appApiService.resetPassword(token: token, email: email, password: password);
//   }

//   @override
//   Future<void> forgotPassword(String email) => _appApiService.forgotPassword(email);

//   @override
//   Future<bool> checkEmail(String email) async {
//     final response = await _appApiService.checkEmail(email: email);
//     return response?.registered ?? false;
//   }

//   // @override
//   // UserEntity getUserPreference() =>   BaseEntity(); // _preferenceUserDataMapper.mapToEntity(_appPreferences.currentUser);

//   @override
//   Future<void> clearCurrentUserData() => _appPreferences.clearCurrentUserData();

//   @override
//   Future<List<UserEntity>> getUsers({required int page, required int? limit}) async {
//     final response = await _appApiService.getUsers(page: page, limit: limit);
//     return response?.results ?? [];
//   }

//   @override
//   Future<UserEntity?> getMe() async {
//     final response = await _appApiService.getMe();
//     return response?.data;
//   }

//   @override
//   Future<String> getAccessToken() async {
//     return await _appPreferences.accessToken;
//   }

//   Future<List<dynamic>> _saveTokenAndUser(AuthModel data) async {
//     Log.d('_saveTokenAndUser: ${data.toJson()}');
//     return Future.wait([
//       _appPreferences.saveCurrentUser(data),
//       if (!data.accessToken.isNullOrEmpty) _appPreferences.saveAccessToken(data.accessToken!),
//       if (!data.refreshToken.isNullOrEmpty) _appPreferences.saveRefreshToken(data.refreshToken!),
//     ]);
//   }
// }
