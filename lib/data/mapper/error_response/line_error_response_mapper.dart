import '../../../shared/index.dart';
import '../../index.dart';

class LineErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(generalMessage: json?['error_description']);
  }
}
