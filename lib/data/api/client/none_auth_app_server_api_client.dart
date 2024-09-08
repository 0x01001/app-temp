import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(HeaderInterceptor _headerInterceptor)
      : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(baseUrl: Constant.appApiBaseUrl),
            interceptors: [
              _headerInterceptor,
            ],
          ),
        );
}
