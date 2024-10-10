import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/index.dart';
import '../../shared/index.dart';
import '../index.dart';

final shareProvider = Provider((_ref) => ShareProvider(_ref));

class ShareProvider {
  ShareProvider(this._ref);

  final Ref _ref;

  Future<String> get deviceToken async {
    final deviceToken = await _ref.firebaseNotification.deviceToken;
    if (deviceToken != null) {
      await _ref.preferences.saveDeviceToken(deviceToken);
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

  List<FirebaseConversationUserModel>? getRenamedMembers({List<FirebaseConversationUserModel>? members, String? conversationId}) {
    return members
        ?.map((e) => e.copyWith(
              email: _ref.preferences.getUserNickname(conversationId: conversationId, memberId: e.userId) ?? e.email,
            ))
        .toList();
  }

  Future<void> deleteConversation(String? id) async {
    if (id != null) {
      await _ref.firebaseFirestore.deleteConversation(id);
      await _ref.database.removeMessagesByConversationId(id);
    }
  }
}

final languageCodeProvider = StateProvider<LanguageCode>(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.preferences.saveLanguageCode(next.value);
    });

    return LanguageCode.fromValue(ref.preferences.languageCode);
  },
);

final isDarkModeProvider = StateProvider<bool?>(
  (ref) {
    ref.listenSelf((previous, next) {
      Log.d('isDarkModeProvider > listenSelf: $previous - $next');
      if (next != previous) {
        ref.preferences.saveIsDarkMode(next ?? false);
      }
    });
    Log.d('isDarkModeProvider > build: ${ref.preferences.isDarkMode}');
    return ref.preferences.isDarkMode;
  },
);

class ShowBottomNav extends StateNotifier<bool> {
  ShowBottomNav() : super(true); // Initial state is true

  void change() => state = !state;
  void hide() => state = false;
  void show() => state = true;
}

final showBottomNavProvider = StateNotifierProvider<ShowBottomNav, bool>((ref) => ShowBottomNav());

final filterConversationsProvider = Provider.autoDispose<List<FirebaseConversationModel>?>(
  (ref) {
    final conversations = ref.watch(conversationProvider.select((value) => value.data?.conversationList));
    final keyword = ref.watch(conversationProvider.select((value) => value.data?.keyword));
    final allConversationsMembers = ref.watch(conversationMembersMapProvider);
    final filteredConversationsMembers = allConversationsMembers.filter(
      (element) => element.value.joinToString(transform: (e) => e.email ?? '').containsIgnoreCase(keyword?.trim() ?? ''),
    );

    return conversations
        ?.filter(
          (conversation) {
            if (allConversationsMembers.containsKey(conversation.id)) {
              return filteredConversationsMembers.containsKey(conversation.id);
            } else {
              return conversation.members?.joinToString(transform: (e) => e.email ?? '').containsIgnoreCase(keyword?.trim() ?? '') ?? false;
            }
          },
        )
        .map((e) => e.copyWith(members: allConversationsMembers[e.id] ?? e.members))
        .toList();
  },
);

final conversationNameProvider = Provider.autoDispose.family<String, String>((ref, conversationId) {
  final currentUser = ref.watch(currentUserProvider);
  final members = ref.watch(conversationMembersMapProvider.select((value) => value[conversationId]));

  members?.removeWhere((element) => element.userId == currentUser.id);

  return members?.joinToString(transform: (e) => e.email ?? '') ?? '';
});

final conversationMembersMapProvider = StateProvider<Map<String, List<FirebaseConversationUserModel>>>((ref) => {});

final conversationMembersProvider = Provider.autoDispose.family<List<FirebaseConversationUserModel>, String>((ref, conversationId) {
  return ref.watch(conversationMembersMapProvider)[conversationId]?.distinctBy((element) => element.userId).toList() ?? [];
});

final currentUserProvider = StateProvider<FirebaseUserModel>(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.preferences.saveUserId(next.id ?? '');
      ref.preferences.saveEmail(next.email ?? '');
    });

    return FirebaseUserModel();
  },
);
