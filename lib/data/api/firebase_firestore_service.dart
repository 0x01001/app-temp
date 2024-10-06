import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

final firebaseFirestoreServiceProvider = Provider<FirebaseFirestoreService>((ref) => getIt.get<FirebaseFirestoreService>());

@LazySingleton()
class FirebaseFirestoreService {
  static const _pathMessages = 'messages';
  static const _pathConversations = 'conversations';
  static const _pathUsers = 'users';

  CollectionReference<Map<String, dynamic>> get _userCollection => FirebaseFirestore.instance.collection(_pathUsers);

  CollectionReference<Map<String, dynamic>> get _conversationCollection => FirebaseFirestore.instance.collection(_pathConversations);

  CollectionReference<Map<String, dynamic>> _messageCollection(String conversationId) => FirebaseFirestore.instance.collection(_pathConversations).doc(conversationId).collection(_pathMessages);

  Future<FirebaseUserModel> getCurrentUser(String userId) async {
    final documentSnapshot = await _userCollection.doc(userId).get();
    return FirebaseUserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateCurrentUser({required String userId, required Map<Object, Object?> data}) async {
    await _userCollection.doc(userId).update(data);
  }

  Future<void> putUserToFireStore({required String userId, required FirebaseUserModel data}) async {
    final createdAt = FieldValue.serverTimestamp();
    final doc = _userCollection.doc(userId);
    await doc.set({
      ...data.toMap(),
      FirebaseUserModel.keyCreatedAt: createdAt,
      FirebaseUserModel.keyUpdatedAt: createdAt,
    });
  }

  Future<void> deleteUser(String id) async {
    await _userCollection.doc(id).delete();
  }

  Future<void> deleteConversation(String id) async {
    await _conversationCollection.doc(id).delete();
  }

  Stream<List<FirebaseConversationModel>> getConversationsStream(String userId) {
    return _conversationCollection.where(FirebaseConversationModel.keyMemberIds, arrayContains: userId).orderBy(FirebaseConversationModel.keyUpdatedAt, descending: true).snapshots().map((event) {
      return event.docs.map((e) => FirebaseConversationModel.fromMap(e.data())).toList();
    });
  }

  Stream<FirebaseUserModel> getUserDetailStream(String userId) {
    return _userCollection.doc(userId).snapshots().map((e) {
      return FirebaseUserModel.fromMap(e.data() ?? {});
    });
  }

  Stream<List<FirebaseUserModel>> getUsersExceptMembersStream(List<String?>? members) {
    return _userCollection.where(FirebaseUserModel.keyId, whereNotIn: members).orderBy(FirebaseUserModel.keyId).orderBy(FirebaseUserModel.keyUpdatedAt, descending: true).snapshots().map((event) {
      return event.docs.map((e) {
        return FirebaseUserModel.fromMap(e.data());
      }).toList();
    });
  }

  Future<FirebaseConversationModel> createConversation(List<FirebaseConversationUserModel> members) async {
    final createdAt = FieldValue.serverTimestamp();

    final collection = _conversationCollection.doc();

    final conversation = FirebaseConversationModel(
      id: collection.id,
      lastMessage: '',
      lastMessageType: MessageType.text.code,
      memberIds: members.map((e) => e.userId ?? '').toList(),
      members: members,
    );
    await collection.set(
      {
        ...conversation.toMap(),
        FirebaseConversationModel.keyCreatedAt: createdAt,
        FirebaseConversationModel.keyUpdatedAt: createdAt,
      },
    );

    Log.d('Added conversation ${conversation.id}');

    return conversation;
  }

  Future<void> addMembers({required String conversationId, required List<FirebaseConversationUserModel> members}) async {
    await _conversationCollection.doc(conversationId).update({
      FirebaseConversationModel.keyMembers: members.map((e) => e.toJson()).toList(),
      FirebaseConversationModel.keyMemberIds: members.map((e) => e.userId).toList(),
    });
  }

  Future<List<FirebaseMessageModel>> getOlderMessages({required String latestMessageId, required String conversationId}) async {
    final messagesCollection = _messageCollection(conversationId);
    final prevDocument = await messagesCollection.doc(latestMessageId).get();

    final querySnapshot = await messagesCollection.orderBy(FirebaseMessageModel.keyCreatedAt, descending: true).startAfterDocument(prevDocument).limit(Constant.itemsPerPage).get();

    return querySnapshot.docs.map((e) => FirebaseMessageModel.fromMap(e.data())).toList();
  }

  Stream<List<FirebaseMessageModel>> getMessagesStream({required String conversationId, required int limit}) {
    return _messageCollection(conversationId).orderBy(FirebaseMessageModel.keyCreatedAt, descending: true).limit(limit).snapshots().map((event) {
      return event.docs
          .map(
            (e) => FirebaseMessageModel.fromMap(e.data()),
          )
          .toList();
    });
  }

  Stream<FirebaseConversationModel?> getConversationDetailStream(String conversationId) {
    return _conversationCollection.doc(conversationId).snapshots().map((event) {
      final data = event.data();

      return data == null ? null : FirebaseConversationModel.fromMap(data);
    });
  }

  String createMessageId(String conversationId) {
    return _messageCollection(conversationId).doc().id;
  }

  Future<void> createMessage({required String currentUserId, required String conversationId, required FirebaseMessageModel message}) async {
    final doc = _messageCollection(conversationId).doc(message.id);

    final createdAt = FieldValue.serverTimestamp();

    await Future.wait([
      doc.set(
        {
          ...message.toMap(),
          FirebaseMessageModel.keyCreatedAt: createdAt,
          FirebaseMessageModel.keyUpdatedAt: createdAt,
        },
      ),
      _conversationCollection.doc(conversationId).update({
        FirebaseConversationModel.keyLastMessage: message.message,
        FirebaseConversationModel.keyLastMessageType: message.type,
        FirebaseConversationModel.keyUpdatedAt: createdAt,
      }),
    ]);
  }
}
