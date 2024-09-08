import '../../../shared/index.dart';
import '../../index.dart';

class PlainResponseMapper<T extends Object> extends BaseSuccessResponseMapper<T, T> {
  @override
  Future<T>? mapToDataModel({required dynamic response, Decoder<T>? decoder}) {
    assert(decoder == null);

    return response is T ? Future.value(response) : null;
  }
}
