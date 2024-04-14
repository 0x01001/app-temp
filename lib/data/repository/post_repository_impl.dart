// import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../domain/index.dart';
import '../index.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._appApiService, this._appPreferences, this._appDatabase, this._appFirebaseAuth);

  final AppApiService _appApiService;
  final AppPreferences _appPreferences;
  final AppDatabase _appDatabase;
  final AppFirebaseAuth _appFirebaseAuth;

  @override
  Future<List<PostEntity>?> getListPost({int? page, int? limit}) async {
    final response = await _appApiService.getListPost(page: page, limit: limit);
    return response.data ?? [];
  }

  // -------------------DATA LOCAL----------------------

  @override
  Future<List<PostEntity>> getListLocal({String? text, int? limit, int? page, int? itemsPerPage}) async {
    return _appDatabase.getAll(text: text, limit: limit, page: page, itemsPerPage: itemsPerPage);
  }

  @override
  Future<void> saveDataLocal(PostEntity data) async {
    return _appDatabase.put(data);
  }

  @override
  Future<PostEntity?> getDataLocal(String? id) async {
    return _appDatabase.getOne(id);
  }
}
