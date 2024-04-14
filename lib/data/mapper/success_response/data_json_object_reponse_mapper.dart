import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../model/base/data_response.dart';
import '../base/base_success_response_mapper.dart';

@Injectable()
class DataJsonObjectResponseMapper<T> extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  // ignore: avoid-dynamic
  Future<DataResponse<T>> map(dynamic response, Decoder<T>? decoder) async {
    if (decoder != null && response is Map<String, dynamic>) {
      final data = await compute((x) => DataResponse.fromJson(x, (json) => decoder(json)), response);
      return data;
    } else {
      return DataResponse<T>(data: response);
    }
    // return decoder != null && response is Map<String, dynamic> ? DataResponse.fromJson(response, (json) => decoder(json)) : DataResponse<T>(data: response);
  }
}
