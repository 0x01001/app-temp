import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';

import '../../../../shared/index.dart';
import '../../../index.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({BaseOptions? options, List<Interceptor> interceptors = const []}) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: options?.connectTimeout ?? Constant.connectTimeout,
        receiveTimeout: options?.receiveTimeout ?? Constant.receiveTimeout,
        sendTimeout: options?.sendTimeout ?? Constant.sendTimeout,
        baseUrl: options?.baseUrl ?? Constant.appApiBaseUrl,
      ),
    );

    final list = [CustomLogInterceptor(), ConnectivityInterceptor(), RetryOnErrorInterceptor(dio), ...interceptors].sortedByDescending((x) {
      return x is BaseInterceptor ? x.priority : -1;
    });

    dio.interceptors.addAll(list);

    return dio;
  }
}
