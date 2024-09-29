import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class MainState extends BaseState {}

final mainProvider = StateNotifierProvider.autoDispose<MainProvider, AppState<MainState>>((ref) => MainProvider(ref));

class MainProvider extends BaseProvider<MainState> {
  MainProvider(this._ref) : super(AppState(data: MainState()));

  final Ref _ref;

  @visibleForTesting
  StreamSubscription<RemoteMessage>? onMessageOpenedAppSubscription;
  @visibleForTesting
  StreamSubscription<String>? onTokenRefreshSubscription;
  @visibleForTesting
  StreamSubscription<FirebaseUserModel>? currentUserSubscription;
  @visibleForTesting
  StreamSubscription<bool>? connectSubscription;

  void _updateCurrentUser(FirebaseUserModel user) => _ref.update<FirebaseUserModel>(currentUserProvider, (_) => user);

  FutureOr<void> init() async {
    Log.start('MainProvider > init > start');
    setInitialCurrentUserState();
    listenConnectivity();
    listenToCurrentUser();
    listenOnDeviceTokenRefresh();
    listenOnMessageOpenedApp();
    await getInitialMessage();
    Log.end('MainProvider > init > end');
  }

  void setInitialCurrentUserState() {
    _updateCurrentUser(FirebaseUserModel(id: _ref.preferences.userId, email: _ref.preferences.email));
  }

  void listenConnectivity() {
    connectSubscription?.cancel();
    connectSubscription = _ref.connectivity.onConnectivityChanged.listen((event) {
      getIt.get<AppInfo>().isConnected = event;
    });
  }

  void listenToCurrentUser() {
    currentUserSubscription?.cancel();
    final userId = _ref.preferences.userId;
    currentUserSubscription = _ref.firebaseFirestore.getUserDetailStream(userId).listen((user) async {
      // user deleted - force logout
      if (user.id?.isEmpty == true) {
        await _ref.nav.showDialog(AppPopup.forceLogout(S.current.forceLogout));
        await _ref.preferences.clearCurrentUserData();
        _updateCurrentUser(FirebaseUserModel());
        await _ref.nav.replaceAll([const LoginRoute()]);
      } else {
        _updateCurrentUser(user);
      }
    });
  }

  void listenOnDeviceTokenRefresh() {
    onTokenRefreshSubscription?.cancel();
    onTokenRefreshSubscription = _ref.firebaseNotification.onTokenRefresh.listen((event) async {
      if (event.isNotEmpty) {
        await _ref.preferences.saveDeviceToken(event);
      }
    });
  }

  void listenOnMessageOpenedApp() {
    onMessageOpenedAppSubscription?.cancel();
    onMessageOpenedAppSubscription = _ref.firebaseNotification.onMessageOpenedApp.listen(
      (event) async {
        // when tab on noti IOS is open and background, android in background
        await _ref.localPush.cancelAll();
        // DeepLinkHelper.getInstance().run(message.data['deeplink']);
        // await goToChatPage(_ref.remoteMessageAppNotificationMapper.mapToLocal(event));
      },
    );
  }

  Future<void> getInitialMessage() async {
    await runSafe(
      action: () async {
        // final initialMessage = await _ref.firebaseNotification.initialMessage;
        // await goToChatPage(_ref.remoteMessageAppNotificationMapper.mapToLocal(initialMessage));
      },
      handleLoading: false,
    );
  }

  // @visibleForTesting
  // Future<void> goToChatPage(AppNotification appNotification) async {
  //   final conversationId = appNotification.conversationId;
  //   if (conversationId.isEmpty) {
  //     return;
  //   }

  //   if (_ref.nav.getCurrentRouteName() == ChatRoute.name) {
  //     final routeData = _ref.nav.getCurrentRouteData();
  //     final arg = routeData.args as ChatRouteArgs;
  //     if (arg.conversation.id != conversationId) {
  //       await _ref.nav.pop();
  //       await _ref.nav.push(ChatRoute(conversation: FirebaseConversationModel(id: conversationId)));
  //     }
  //   } else {
  //     await _ref.nav.push(ChatRoute(conversation: FirebaseConversationModel(id: appNotification.conversationId)));
  //   }
  // }

  @override
  void dispose() {
    onMessageOpenedAppSubscription?.cancel();
    onTokenRefreshSubscription?.cancel();
    currentUserSubscription?.cancel();
    connectSubscription?.cancel();
    onMessageOpenedAppSubscription = null;
    onTokenRefreshSubscription = null;
    currentUserSubscription = null;
    connectSubscription = null;
    super.dispose();
  }
}
