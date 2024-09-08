import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../shared/index.dart';
import 'base_interceptor.dart';

class BasicAuthInterceptor extends BaseInterceptor {
  BasicAuthInterceptor({required this.username, required this.password});

  final String password;
  final String username;

  @override
  int get priority => BaseInterceptor.basicAuthPriority;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[Constant.basicAuthorization] = _basicAuthenticationHeader();

    return super.onRequest(options, handler);
  }

  String _basicAuthenticationHeader() {
    return 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }
}
