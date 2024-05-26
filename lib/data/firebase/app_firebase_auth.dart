import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

@LazySingleton()
class AppFirebaseAuth {
  AppFirebaseAuth();

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Log.d('AppFirebase: User is currently signed out!');
      } else {
        Log.d('AppFirebase: User is signed in!');
        //TODO: go to home
      }
    });
  }

  Future<AuthModel?> register({required String name, required String email, required String password}) async {
    AuthModel? user;

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();
      final result = userCredential.user;
      if (result != null) {
        user = AuthModel(uid: result.uid, email: result.email, displayName: result.displayName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const MessageException(MessageExceptionKind.passwordTooWeak);
      } else if (e.code == 'email-already-in-use') {
        throw const MessageException(MessageExceptionKind.accountAlreadyExists);
      }
    } catch (e) {
      Log.e('AppFirebase > register: $e');
      throw RemoteException(kind: RemoteExceptionKind.unknown, rootException: e);
    }

    return user;
  }

  Future<AuthModel?> login({required String email, required String password}) async {
    AuthModel? user;

    try {
      Log.d('AppFirebase > login: $email');
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final result = userCredential.user;
      if (result != null) {
        user = AuthModel(uid: result.uid, email: result.email, displayName: result.displayName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const MessageException(MessageExceptionKind.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw const MessageException(MessageExceptionKind.wrongPassword);
      }
    } catch (e) {
      Log.e('AppFirebase > login: $e');
      throw RemoteException(kind: RemoteExceptionKind.unknown, rootException: e);
    }

    return user;
  }

  // Future<bool> autoRefresh() async {
  //   try {
  //     final result = FirebaseAuth.instance.currentUser;
  //     if (result != null) {
  //       final token = await result.getIdToken(true);
  //       Log.d('AppFirebase > autoRefresh: $token');
  //       return token.isNotEmpty;
  //     }
  //   } catch (e) {
  //     Log.e('AppFirebase > autoRefresh: $e');
  //   }
  //   return false;
  // }

  bool get isLoggedIn {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> logout() => FirebaseAuth.instance.signOut();
}
