import '../../shared/index.dart';
import '../index.dart';

class AppState<T extends BaseState> {
  final T? data;
  final AppException? appException;
  final bool? isLoading;
  AppState({this.data, this.appException, this.isLoading});

  AppState<T> copyWith({T? data, AppException? appException, bool? isLoading}) {
    return AppState<T>(
      data: data ?? this.data,
      appException: appException ?? this.appException,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() => 'BaseState(data: $data, appException: $appException, isLoading: $isLoading)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState<T> && other.data == data && other.appException == appException && other.isLoading == isLoading;
  }

  @override
  int get hashCode => data.hashCode ^ appException.hashCode ^ isLoading.hashCode;
}
