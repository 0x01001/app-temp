import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

final firebaseDatabaseProvider = Provider<FirebaseDatabaseService>((ref) => getIt.get<FirebaseDatabaseService>());

@LazySingleton()
class FirebaseDatabaseService {
  static const _pathUsers = 'users';
  final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://eam-app-5b5b4-default-rtdb.asia-southeast1.firebasedatabase.app/');
  DatabaseReference get _userCollection => rtdb.ref(_pathUsers);

  Future<FirebaseUserModel> getCurrentUser(String userId) async {
    final snapshot = await _userCollection.child(userId).get();
    if (snapshot.exists) {
      return FirebaseUserModel.fromMap(Map<String, dynamic>.from(snapshot.value as Map));
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> updateCurrentUser({required String userId, required Map<String, Object?> data}) async {
    await _userCollection.child(userId).update(data);
  }

  Future<void> putUserToRealtimeDB({required String userId, required FirebaseUserModel data}) async {
    await _userCollection.child(userId).set({...data.toMap(), FirebaseUserModel.keyCreatedAt: ServerValue.timestamp, FirebaseUserModel.keyUpdatedAt: ServerValue.timestamp});
  }

  Future<void> deleteUser(String? id) async {
    await _userCollection.child(id!).remove();
  }

  // Stream<FirebaseUserModel?> getUserDetailStream(String userId) {
  //   return _userCollection.child(userId).onValue.map((event) {
  //     final data = event.snapshot.value;
  //     if (data == null) return null;
  //     return FirebaseUserModel.fromMap(Map<String, dynamic>.from(data as Map));
  //   });
  // }

  // Stream<List<FirebaseUserModel?>> getUsersExceptMembersStream(List<String?>? members) {
  //   return _userCollection.onValue.map((event) {
  //     final data = event.snapshot.value;
  //     if (data == null) return [];
  //     return Map<String, dynamic>.from(data as Map).entries.where((e) => !members!.contains(e.key)).map((e) => FirebaseUserModel.fromMap(e.value)).toList();
  //   });
  // }
}
