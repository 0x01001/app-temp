import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@LazySingleton()
class AppDatabase {
  AppDatabase(this.isar);

  final Isar isar;

  // Future<void> put(PostEntity data) async {
  //   return await isar.writeTxn(() async {
  //     await isar.postEntitys.put(data); // insert & update
  //   });
  // }

  // Future<List<PostEntity>> getAll({String? text, int? limit, int? page, int? itemsPerPage}) async {
  //   final _limit = (limit ?? itemsPerPage) ?? Constant.itemsPerPage;
  //   final _offset = page ?? Constant.initialPage;
  //   Log.d('AppDatabase > getAll:  - $_limit - $_offset');
  //   final query = isar.postEntitys.filter().textContains(text ?? '', caseSensitive: false).sortByPublishDateDesc().offset(_offset).limit(_limit).findAll();
  //   return query;
  // }

  // Future<PostEntity?> getOne(String? id) {
  //   return isar.postEntitys.filter().idEqualTo(id).findFirst();
  // }

  // Future<PostEntity?> getOneByLocalId(int id) {
  //   return isar.postEntitys.get(id);
  // }

  // Future<void> delete(int id) async {
  //   return isar.writeTxn(() async {
  //     await isar.postEntitys.delete(id); // delete
  //   });
  // }
}
