typedef Decoder<T> = T Function(Map<String, dynamic> data);
typedef Loader<T> = Future<void> Function({int? page, int? limit, bool? isRefresh});
