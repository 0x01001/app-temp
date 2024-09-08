import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class JsonObjectResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, T> {
  @override
  Future<T>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    // return decoder != null && response is Map<String, dynamic> ? decoder(response) : response;
    if (decoder != null && response is Map<String, dynamic>) {
      return await compute(decoder, response);
    } else {
      return response;
    }
  }
}
