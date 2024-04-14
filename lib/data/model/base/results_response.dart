import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResultsListResponse<T> {
  ResultsListResponse({@JsonKey(name: 'results') this.results});

  factory ResultsListResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) => _$ResultsListResponseFromJson(json, fromJsonT);

  final List<T>? results;
}
