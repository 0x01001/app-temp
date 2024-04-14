import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../model/base/data_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class DataJsonArrayResponseMapper<T> extends BaseSuccessResponseMapper<T, DataListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  Future<DataListResponse<T>> map(dynamic response, Decoder<T>? decoder) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => DataListResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return DataListResponse<T>(data: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? DataListResponse.fromJson(response, (json) => decoder(json)) : DataListResponse<T>(data: response);
  }
}
