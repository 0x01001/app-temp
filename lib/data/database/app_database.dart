import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../shared/index.dart';
import '../index.dart';

@LazySingleton()
class AppDatabase {
  AppDatabase(this.isar, this.appPreferences);

  final Isar isar;
  final AppPreferences appPreferences;

  String get userId => appPreferences.userId;

  Future<int> removeMessagesByConversationId(String id) {
    return isar.writeTxn(() {
      return isar.localMessageDatas.filter().conversationIdEqualTo(id).userIdEqualTo(userId).deleteAll();
    });
  }

  List<LocalMessageData> getLatestMessages(String conversationId) {
    return isar.localMessageDatas.filter().conversationIdEqualTo(conversationId).userIdEqualTo(userId).sortByCreatedAtDesc().limit(Constant.itemsPerPage).build().findAllSync();
  }

  Stream<List<LocalMessageData>> getMessagesStream(String conversationId) {
    return isar.localMessageDatas.filter().conversationIdEqualTo(conversationId).userIdEqualTo(userId).sortByCreatedAtDesc().build().watch(fireImmediately: true);
  }

  Future<void> putMessages(List<LocalMessageData> messages) async {
    await isar.writeTxn(() async {
      await isar.localMessageDatas.putAll(messages);
    });
  }

  Future<void> putMessage(LocalMessageData message) async {
    await isar.writeTxn(() async {
      await isar.localMessageDatas.put(message);
    });
  }

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
