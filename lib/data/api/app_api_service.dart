import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

final appApiServiceProvider = Provider<AppApiService>((ref) => getIt.get<AppApiService>());

@LazySingleton()
class AppApiService {
  AppApiService(this._noneAuthAppServerApiClient, this._authAppServerApiClient);

  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;
  final AuthAppServerApiClient _authAppServerApiClient;
  // final RandomUserApiClient _randomUserApiClient;

  Future<AuthModel?> login(String email, String password) async {
    return _noneAuthAppServerApiClient.request(
      method: Method.post,
      path: 'accounts:signInWithPassword?key=${Env.apiKey}',
      body: {'email': email, 'password': password, 'returnSecureToken': true},
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<void> logout() async {
    await _authAppServerApiClient.request(method: Method.post, path: '/v1/auth/logout');
  }

  Future<AuthModel?> register(String email, String password, String? name) async {
    return _noneAuthAppServerApiClient.request(
      method: Method.post,
      // path: '/v1/auth/register',
      path: 'accounts:signUp?key=${Env.apiKey}',
      body: {
        // 'username': username,
        // 'gender': gender,
        'email': email,
        'password': password,
        // 'name': name,
        'returnSecureToken': true,
      },
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<AuthModel?> checkEmail(String email) async {
    return _noneAuthAppServerApiClient.request(
      method: Method.post,
      path: 'accounts:createAuthUri?key=${Env.apiKey}',
      body: {'identifier': email, 'continueUri': 'http://localhost'},
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<void> forgotPassword(String email) async {
    await _noneAuthAppServerApiClient.request(
      method: Method.post,
      path: '/v1/auth/forgot-password',
      body: {'email': email},
    );
  }

  Future<void> resetPassword({required String token, required String email, required String password}) async {
    await _noneAuthAppServerApiClient.request(
      method: Method.post,
      path: '/v1/auth/reset-password',
      body: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
  }

  // Future<DataResponse<UserEntity>?> getMe() async {
  //   return _noneAuthAppServerApiClient.request(method: RestMethod.get, path: '/v1/me', decoder: AuthModel.fromMap);
  // }

  /// [page]: number of page
  /// [limit]: number of items on page
  Future<DataListResponse<UserModel>?> getListUser({int? page = Constant.initialPage, int? limit = Constant.itemsPerPage}) async {
    return _authAppServerApiClient.request(
      method: Method.get,
      path: 'user',
      queryParameters: {'page': page, 'limit': limit},
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: UserModel.fromMap,
    );
  }
}
