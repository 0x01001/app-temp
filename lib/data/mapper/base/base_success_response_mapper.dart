import '../../../shared/index.dart';
import '../success_response/data_json_array_response_mapper.dart';
import '../success_response/data_json_object_reponse_mapper.dart';
import '../success_response/json_array_response_mapper.dart';
import '../success_response/json_object_reponse_mapper.dart';
import '../success_response/records_json_array_response_mapper.dart';
import '../success_response/results_json_array_response_mapper.dart';

abstract class BaseSuccessResponseMapper<I, O> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    switch (type) {
      case SuccessResponseMapperType.dataJsonObject:
        return DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.dataJsonArray:
        return DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonObject:
        return JsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.jsonArray:
        return JsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.recordsJsonArray:
        return RecordsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
      case SuccessResponseMapperType.resultsJsonArray:
        return ResultsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>;
    }
  }

  // ignore: avoid-dynamic
  Future<O> map(dynamic response, Decoder<I>? decoder);
}
