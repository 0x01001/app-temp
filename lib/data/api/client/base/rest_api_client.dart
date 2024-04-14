import 'package:dio/dio.dart';

import '../../../../shared/index.dart';
import '../../../mapper/base/base_error_response_mapper.dart';
import '../../../mapper/base/base_success_response_mapper.dart';
import '../../exception_mapper/dio_exception_mapper.dart';

enum RestMethod { get, post, put, patch, delete }

class RestApiClient {
  RestApiClient({
    required this.dio,
    this.errorResponseMapperType = ServerConstants.defaultErrorResponseMapperType,
    this.successResponseMapperType = ServerConstants.defaultSuccessResponseMapperType,
  });

  final SuccessResponseMapperType successResponseMapperType;
  final ErrorResponseMapperType errorResponseMapperType;
  final Dio dio;

  Future<T> request<T, D>({
    required RestMethod method,
    required String path,
    String? url,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Decoder<D>? decoder,
    SuccessResponseMapperType? successResponseMapperType,
    ErrorResponseMapperType? errorResponseMapperType,
    BaseErrorResponseMapper<dynamic>? errorResponseMapper,
    Map<String, dynamic>? headers,
    String? contentType,
    ResponseType? responseType,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) async {
    try {
      if (url != null) dio.options.baseUrl = url; // change base url
      final response = await _requestByMethod(
        method: method,
        path: path.startsWith(dio.options.baseUrl) ? path.substring(dio.options.baseUrl.length) : path,
        queryParameters: queryParameters,
        body: body,
        options: Options(
          headers: headers,
          contentType: contentType,
          responseType: responseType,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
      );
      if (responseType == ResponseType.plain) return response.data;
      return await BaseSuccessResponseMapper<D, T>.fromType(successResponseMapperType ?? this.successResponseMapperType).map(response.data, decoder);
    } catch (error) {
      throw DioExceptionMapper(errorResponseMapper ?? BaseErrorResponseMapper.fromType(errorResponseMapperType ?? this.errorResponseMapperType)).map(error);
    }
  }

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    return dio.fetch(requestOptions);
  }

  Future<Response<dynamic>> _requestByMethod({
    required RestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    // ignore: avoid-dynamic
    dynamic body,
    Options? options,
  }) {
    switch (method) {
      case RestMethod.get:
        return dio.get(path, queryParameters: queryParameters, options: options);
      case RestMethod.post:
        return dio.post(path, data: body, queryParameters: queryParameters, options: options);
      case RestMethod.patch:
        return dio.patch(path, data: body, queryParameters: queryParameters, options: options);
      case RestMethod.put:
        return dio.put(path, data: body, queryParameters: queryParameters, options: options);
      case RestMethod.delete:
        return dio.delete(path, data: body, queryParameters: queryParameters, options: options);
    }
  }
}
