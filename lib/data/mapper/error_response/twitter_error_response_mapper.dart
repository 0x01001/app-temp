import 'package:dartx/dartx.dart';

import '../../index.dart';

class TwitterErrorResponseMapper extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? json) {
    return ServerError(
      generalMessage:
          // ignore: avoid-dynamic
          ((json?['errors'] as List<dynamic>?)?.firstOrNull as Map<String, dynamic>)['message'] ?? '',
    );
  }
}
