import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@LazySingleton()
class RefreshTokenApiClient extends RestApiClient {
  RefreshTokenApiClient(HeaderInterceptor _headerInterceptor, AccessTokenInterceptor _accessTokenInterceptor)
      : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(baseUrl: UrlConstants.appApiBaseUrl),
            interceptors: [
              _headerInterceptor,
              _accessTokenInterceptor,
            ],
          ),
        );
}
