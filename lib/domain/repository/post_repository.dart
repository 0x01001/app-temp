import '../index.dart';

abstract class PostRepository {
  Future<List<PostEntity>?> getListPost({int? page, int? limit});

  // -------------------DATA LOCAL----------------------

  Future<List<PostEntity>> getListLocal({String? text, int? limit, int? page, int? itemsPerPage});

  Future<void> saveDataLocal(PostEntity data);

  Future<PostEntity?> getDataLocal(String? id);
}
