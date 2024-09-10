import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/index.dart';
import '../../shared/index.dart';

final shareProvider = Provider((_ref) => ShareProvider(_ref));

class ShareProvider {
  ShareProvider(this._ref);

  final Ref _ref;

  Future<String> get deviceToken async {
    final deviceToken = await _ref.firebaseNotification.deviceToken;
    if (deviceToken != null) {
      await _ref.appPreferences.saveDeviceToken(deviceToken);
    }

    return deviceToken ?? '';
  }

  // Future<void> forceLogout() async {
  //   try {
  //     await _ref.appPreferences.clearCurrentUserData();
  //     _ref.update<FirebaseUserData>(currentUserProvider, (state) => const FirebaseUserData());
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   } catch (e) {
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     final deviceToken = await this.deviceToken;
  //     final userId = _ref.appPreferences.userId;
  //     await _ref.firebaseFirestoreService.updateCurrentUser(userId: userId, data: {
  //       FirebaseUserData.keyDeviceIds: [],
  //       FirebaseUserData.keyDeviceTokens: FieldValue.arrayRemove([deviceToken]),
  //     });
  //     await _ref.appPreferences.clearCurrentUserData();
  //     await _ref.firebaseAuthService.signOut();
  //     _ref.update<FirebaseUserData>(currentUserProvider, (state) => const FirebaseUserData());
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   } catch (e) {
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   }
  // }

  // List<FirebaseConversationUserData> getRenamedMembers({required List<FirebaseConversationUserData> members, required String conversationId}) {
  //   return members
  //       .map((e) => e.copyWith(
  //             email: _ref.appPreferences.getUserNickname(
  //                   conversationId: conversationId,
  //                   memberId: e.userId,
  //                 ) ??
  //                 e.email,
  //           ))
  //       .toList();
  // }

  // Future<void> deleteConversation(FirebaseConversationData conversation) async {
  //   await _ref.firebaseFirestoreService.deleteConversation(conversation.id);
  //   await _ref.appDatabase.removeMessagesByConversationId(conversation.id);
  // }
}

final languageCodeProvider = StateProvider<LanguageCode>(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.appPreferences.saveLanguageCode(next.value);
    });

    return LanguageCode.fromValue(ref.appPreferences.languageCode);
  },
);

// final isDarkModeProvider = StateProvider<bool>(
//   (ref) {
//     ref.listenSelf((previous, next) {
//       ref.appPreferences.saveIsDarkMode(next);
//     });

//     return ref.appPreferences.isDarkMode;
//   },
// );

class ShowBottomNav extends StateNotifier<bool> {
  ShowBottomNav() : super(true); // Initial state is true

  void change() => state = !state;
  void hide() => state = false;
  void show() => state = true;
}

final showBottomNavProvider = StateNotifierProvider<ShowBottomNav, bool>((ref) => ShowBottomNav());

final currentUserProvider = StateProvider<FirebaseUserModel>(
  (ref) {
    ref.listenSelf((previous, next) {
      // ref.appPreferences.saveUserId(next.id);
      // ref.appPreferences.saveEmail(next.email);
    });

    return FirebaseUserModel();
  },
);
