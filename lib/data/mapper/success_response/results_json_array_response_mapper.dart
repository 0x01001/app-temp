import 'package:flutter/foundation.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class ResultsJsonArrayResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, ResultsListResponse<T>> {
  @override
  Future<ResultsListResponse<T>>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => ResultsListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return ResultsListResponse<T>(results: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? ResultsListResponse.fromJson(response, (json) => decoder(json)) : ResultsListResponse<T>(results: response);
  }
}
