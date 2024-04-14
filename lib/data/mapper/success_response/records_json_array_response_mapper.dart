import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../model/base/records_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class RecordsJsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, RecordsListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  Future<RecordsListResponse<T>> map(dynamic response, Decoder<T>? decoder) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => RecordsListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return RecordsListResponse<T>(records: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? RecordsListResponse.fromJson(response, (json) => decoder(json)) : RecordsListResponse<T>(records: response);
  }
}
