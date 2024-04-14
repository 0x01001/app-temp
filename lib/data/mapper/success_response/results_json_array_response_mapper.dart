import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../model/base/results_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class ResultsJsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, ResultsListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  Future<ResultsListResponse<T>> map(dynamic response, Decoder<T>? decoder) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => ResultsListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return ResultsListResponse<T>(results: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? ResultsListResponse.fromJson(response, (json) => decoder(json)) : ResultsListResponse<T>(results: response);
  }
}
