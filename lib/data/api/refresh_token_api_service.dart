import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshTokenApiClient _refreshTokenApiClient;

  Future<DataResponse<RefreshTokenModel>> refreshToken(String refreshToken) async {
    try {
      final respone = await _refreshTokenApiClient.request(method: RestMethod.post, path: '/v1/auth/refresh', decoder: RefreshTokenModel.fromMap);
      return respone;
    } catch (e) {
      if (e is RemoteException && (e.kind == RemoteExceptionKind.serverDefined || e.kind == RemoteExceptionKind.serverUndefined)) {
        throw const RemoteException(kind: RemoteExceptionKind.refreshTokenFailed);
      }
      rethrow;
    }
  }
}
