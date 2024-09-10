import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../app/index.dart';
import '../../../shared/index.dart';
import 'base_interceptor.dart';

@Injectable()
class ConnectivityInterceptor extends BaseInterceptor {
  @override
  int get priority => BaseInterceptor.connectivityPriority;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    bool? result = getIt.get<AppInfo>().isConnected;
    // Log.d('onRequest > result: $result');
    result ??= await getIt.get<AppConnectivity>().isNetworkAvailable;
    if (!result) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: RemoteException(kind: RemoteExceptionKind.noInternet),
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
