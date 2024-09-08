import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class RecordsJsonArrayResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, RecordsListResponse<T>> {
  @override
  Future<RecordsListResponse<T>>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => RecordsListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return RecordsListResponse<T>(records: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? RecordsListResponse.fromJson(response, (json) => decoder(json)) : RecordsListResponse<T>(records: response);
  }
}
