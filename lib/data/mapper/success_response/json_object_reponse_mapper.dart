import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class JsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, T> {
  @override
  // ignore: avoid-dynamic
  Future<T> map(dynamic response, Decoder<T>? decoder) async {
    // return decoder != null && response is Map<String, dynamic> ? decoder(response) : response;
    if (decoder != null && response is Map<String, dynamic>) {
      return await compute(decoder, response);
    } else {
      return response;
    }
  }
}
