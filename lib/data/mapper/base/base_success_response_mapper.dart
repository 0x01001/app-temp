import '../../../shared/index.dart';
import '../../index.dart';

abstract class BaseSuccessResponseMapper<I extends Object, O extends Object> {
  const BaseSuccessResponseMapper();

  factory BaseSuccessResponseMapper.fromType(SuccessResponseMapperType type) {
    return switch (type) {
      SuccessResponseMapperType.dataJsonObject => DataJsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.dataJsonArray => DataJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.jsonObject => JsonObjectResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.jsonArray => JsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.recordsJsonArray => RecordsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.resultsJsonArray => ResultsJsonArrayResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
      SuccessResponseMapperType.plain => PlainResponseMapper<I>() as BaseSuccessResponseMapper<I, O>,
    };
  }

  // ignore: avoid-dynamic
  Future<O>? map({required dynamic response, Decoder<I>? decoder}) {
    assert(response != null);
    try {
      return mapToDataModel(response: response, decoder: decoder);
    } on RemoteException catch (_) {
      rethrow;
    } catch (e) {
      throw RemoteException(kind: RemoteExceptionKind.decodeError, rootException: e);
    }
  }

  // ignore: avoid-dynamic
  Future<O>? mapToDataModel({required dynamic response, Decoder<I>? decoder});
}
