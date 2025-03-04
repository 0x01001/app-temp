import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../shared/index.dart';
import 'base_interceptor.dart';

class CustomLogInterceptor extends BaseInterceptor {
  CustomLogInterceptor({
    this.enableLogRequestInfo = Constant.enableLogRequestInfo,
    this.enableLogSuccessResponse = Constant.enableLogSuccessResponse,
    this.enableLogErrorResponse = Constant.enableLogErrorResponse,
  });

  final bool enableLogRequestInfo;
  final bool enableLogSuccessResponse;
  final bool enableLogErrorResponse;

  static const _enableLogInterceptor = Constant.enableLogInterceptor;

  @override
  int get priority => BaseInterceptor.customLogPriority;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_enableLogInterceptor || !enableLogRequestInfo) {
      handler.next(options);
      return;
    }

    final log = <String>[];
    log.add('\n************ Request ************');
    log.add('Request: ${options.method} ${options.uri}');
    if (options.headers.isNotEmpty) {
      log.add('Request Headers:');
      log.add(_prettyResponse(options.headers));
    }

    if (options.data != null) {
      log.add('Request Body:');
      if (options.data is FormData) {
        final data = options.data as FormData;
        if (data.fields.isNotEmpty) {
          log.add('Fields: ${_prettyResponse(data.fields)}');
        }
        if (data.files.isNotEmpty) {
          log.add('Files: ${_prettyResponse(data.files.map((e) => MapEntry(e.key, 'File name: ${e.value.filename}, Content type: ${e.value.contentType}, Length: ${e.value.length}')))}');
        }
      } else {
        log.add(_prettyResponse(options.data));
      }
    }
    log.add('************ End Request ************');
    Log.r(log.join('\n'));

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (!_enableLogInterceptor || !enableLogSuccessResponse) {
      handler.next(response);
      return;
    }

    final log = <String>[];
    log.add('\n************ Response ************');
    // log.add('${response.requestOptions.method} ${response.requestOptions.uri}');
    // log.add('Request Body: ${_prettyResponse(response.requestOptions.data)}');
    log.add('Response Code: ${response.statusCode}');
    log.add(_cURL(response.requestOptions));
    // log.add('Response Data:');
    // final data = response.data.toString().length > 2000 ? response.data.toString().substring(0, 2000) : response.data.toString();
    // log.add(data); //log.add(response.data.toString()); // log.add(_prettyResponse(response.data));
    log.add('************ End Response ************');
    Log.r(log.join('\n'));

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!_enableLogInterceptor || !enableLogErrorResponse) {
      handler.next(err);
      return;
    }

    final log = <String>[];
    log.add('\n************ Request Error ************');
    // log.add('${err.requestOptions.method} ${err.requestOptions.uri}');
    log.add('Error Code: ${err.response?.statusCode ?? 'unknown status code'}');
    log.add(_cURL(err.requestOptions));
    log.add('Json: ${err.response}');
    log.add('************ End Request Error ************');
    Log.e(log.join('\n'));

    handler.next(err);
  }

  // ignore: avoid-dynamic
  String _prettyResponse(dynamic data) {
    if (data is Map) {
      return Log.prettyJson(data as Map<String, dynamic>);
    }

    return data.toString();
  }

  String _cURL(RequestOptions options) {
    final List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    final decodedUrl = Uri.decodeComponent(options.uri.toString());
    components.add('"$decodedUrl"');

    // return components.join(' \\\n\t');
    return components.join(' ');
  }
}
