import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../app/index.dart';
import '../../../domain/index.dart';
import '../../../shared/index.dart';
import 'base_interceptor.dart';

@Injectable()
class ConnectivityInterceptor extends BaseInterceptor {
  @override
  int get priority => BaseInterceptor.connectivityPriority;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final repository = getIt.get<AppRepository>();
    bool? result = repository.isConnected;
    // Log.d('onRequest > result: $result');
    if (result == null) {
      final connectivityResult = await Connectivity().checkConnectivity();
      result = connectivityResult != ConnectivityResult.none;
    }
    if (!result) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const RemoteException(kind: RemoteExceptionKind.noInternet),
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
