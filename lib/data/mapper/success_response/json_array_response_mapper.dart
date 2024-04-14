import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class JsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, List<T>> {
  @override
  // ignore: avoid-dynamic
  Future<List<T>> map(dynamic response, Decoder<T>? decoder) async {
    if (decoder != null && response is List) {
      final data = await compute((x) => x.map((jsonObject) => decoder(jsonObject)).toList(growable: false), response);
      return data;
    } else {
      return [response];
    }
    // return decoder != null && response is List ? response.map((jsonObject) => decoder(jsonObject)).toList(growable: false) : [response];
  }
}
