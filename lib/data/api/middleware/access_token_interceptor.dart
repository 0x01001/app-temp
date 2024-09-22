import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../database/app_preferences.dart';
import 'base_interceptor.dart';

@Injectable()
class AccessTokenInterceptor extends BaseInterceptor {
  AccessTokenInterceptor(this._appPreferences);

  final AppPreferences _appPreferences;

  @override
  int get priority => BaseInterceptor.accessTokenPriority;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _appPreferences.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers[Constant.basicAuthorization] = '${Constant.bearer} $token';
    }
    handler.next(options);
  }
}
