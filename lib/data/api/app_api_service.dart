import 'package:injectable/injectable.dart';

import '../../domain/index.dart';
import '../../shared/index.dart';
import '../index.dart';

@LazySingleton()
class AppApiService {
  AppApiService(this._noneAuthAppServerApiClient, this._authAppServerApiClient, this._randomUserApiClient);

  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;
  final AuthAppServerApiClient _authAppServerApiClient;
  final RandomUserApiClient _randomUserApiClient;

  Future<AuthModel?> login(String email, String password) async {
    return _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: 'accounts:signInWithPassword?key=${EnvConstants.apiKey}',
      body: {'email': email, 'password': password, 'returnSecureToken': true},
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<void> logout() async {
    await _authAppServerApiClient.request(method: RestMethod.post, path: '/v1/auth/logout');
  }

  Future<AuthModel> register({required String email, required String password}) async {
    return _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      // path: '/v1/auth/register',
      path: 'accounts:signUp?key=${EnvConstants.apiKey}',
      body: {
        // 'username': username,
        // 'gender': gender,
        'email': email,
        'password': password,
        // 'password_confirmation': password,
        'returnSecureToken': true,
      },
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<AuthModel> checkEmail({required String email}) async {
    return _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: 'accounts:createAuthUri?key=${EnvConstants.apiKey}',
      body: {'identifier': email, 'continueUri': 'http://localhost'},
      decoder: AuthModel.fromMap,
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
    );
  }

  Future<void> forgotPassword(String email) async {
    await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/forgot-password',
      body: {'email': email},
    );
  }

  Future<void> resetPassword({required String token, required String email, required String password}) async {
    await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/reset-password',
      body: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
  }

  Future<DataResponse<UserEntity>> getMe() async {
    return _noneAuthAppServerApiClient.request(method: RestMethod.get, path: '/v1/me', decoder: AuthModel.fromMap);
  }

  Future<ResultsListResponse<UserEntity>> getUsers({int? page, int? limit}) {
    return _randomUserApiClient.request(
      method: RestMethod.get,
      path: '',
      queryParameters: {'page': page ?? UiConstants.initialPage, 'limit': limit ?? UiConstants.itemsPerPage},
      successResponseMapperType: SuccessResponseMapperType.resultsJsonArray,
      decoder: UserModel.fromMap,
    );
  }

  Future<DataListResponse<PostModel>> getListPost({int? page, int? limit}) async {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: 'post',
      queryParameters: {'page': page ?? UiConstants.initialPage, 'limit': limit ?? UiConstants.itemsPerPage},
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: PostModel.fromMap,
    );
  }
}
