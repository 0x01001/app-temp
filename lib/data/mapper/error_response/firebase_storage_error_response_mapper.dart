import '../../index.dart';

class FirebaseStorageErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(
      generalServerStatusCode: json?['error']['code'],
      generalMessage: json?['error']['message'],
    );
  }
}
