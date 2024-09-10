import '../../index.dart';

class JsonArrayErrorResponseMapper extends BaseErrorResponseMapper<List<dynamic>> {
  @override
  ServerError mapToServerError(List<dynamic>? data) {
    return ServerError(
      errors: data
              ?.map((dynamic jsonObject) => ServerErrorDetail(
                    serverStatusCode: jsonObject['code'],
                    message: jsonObject['message'],
                  ))
              .toList(growable: false) ??
          [],
    );
  }
}
