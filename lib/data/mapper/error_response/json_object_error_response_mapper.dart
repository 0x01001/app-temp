import '../../index.dart';

class JsonObjectErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? data) {
    return ServerError(
      generalServerStatusCode: data?['error']?['status_code'],
      generalServerErrorId: data?['error']?['error_code'],
      generalMessage: data?['error']?['message'],
    );
  }
}
