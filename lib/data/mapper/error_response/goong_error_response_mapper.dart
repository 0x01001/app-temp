import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../base/base_error_response_mapper.dart';

@Injectable()
class GoongErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToEntity(Map<String, dynamic>? json) {
    return ServerError(
      generalMessage: json?['error']['message'],
    );
  }
}
