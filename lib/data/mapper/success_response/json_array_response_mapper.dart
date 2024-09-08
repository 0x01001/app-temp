import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class JsonArrayResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, List<T>> {
  @override
  Future<List<T>>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    if (decoder != null && response is List) {
      final data = await compute((x) => x.map((jsonObject) => decoder(jsonObject)).toList(growable: false), response);
      return data;
    } else {
      return [response];
    }
    // return decoder != null && response is List ? response.map((jsonObject) => decoder(jsonObject)).toList(growable: false) : [response];
  }
}
