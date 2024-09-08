import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class DataJsonObjectResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  Future<DataResponse<T>>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => DataResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return DataResponse<T>(data: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? DataResponse.fromJson(response, (json) => decoder(json)) : DataResponse<T>(data: response);
  }
}
