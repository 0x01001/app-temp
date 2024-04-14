import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../base/base_error_response_mapper.dart';

@Injectable()
class FirebaseStorageErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToEntity(Map<String, dynamic>? json) {
    return ServerError(
      generalServerStatusCode: json?['error']['code'],
      generalMessage: json?['error']['message'],
    );
  }
}
