import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class DataJsonArrayResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, DataListResponse<T>> {
  @override
  Future<DataListResponse<T>>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => DataListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return DataListResponse<T>(data: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? DataListResponse.fromJson(response, (json) => decoder(json)) : DataListResponse<T>(data: response);
  }
}
