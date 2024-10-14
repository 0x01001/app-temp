import 'dart:async';
import 'dart:math';

import 'package:chatview/chatview.dart';
import 'package:clock/clock.dart';
import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

class ChatState extends BaseState {
  ChatState({this.isLastPage = false, this.isAdmin, this.messages = const [], this.conversation});

  bool? isLastPage;
  bool? isAdmin;
  List<LocalMessageData>? messages;
  FirebaseConversationModel? conversation;

  ChatState copyWith({bool? isLastPage, bool? isAdmin, List<LocalMessageData>? messages, FirebaseConversationModel? conversation}) {
    return ChatState(
      isLastPage: isLastPage ?? this.isLastPage,
      isAdmin: isAdmin ?? this.isAdmin,
      messages: messages ?? this.messages,
      conversation: conversation ?? this.conversation,
    );
  }
}

final chatProvider = StateNotifierProvider.autoDispose.family<ChatProvider, AppState<ChatState>, FirebaseConversationModel>(
  (ref, conversation) => ChatProvider(ref, conversation),
);

class ChatProvider extends BaseProvider<ChatState> {
  ChatProvider(this._ref, FirebaseConversationModel? conversation) : super(AppState(data: ChatState(conversation: conversation)));

  final Ref _ref;

  StreamSubscription<List<LocalMessageData>>? _messagesSubscription;
  StreamSubscription<void>? _messagesFromFirestoreSubscription;
  StreamSubscription<FirebaseConversationModel?>? _conversationSubscription;
  LocalMessageData? get oldestMessage => data?.messages?.lastOrNull;
  LocalMessageData? get latestMessage => data?.messages?.firstOrNull;

  void init() {
    initState();
    listenToConversationDetail();
    listenToMessagesFromFirestore(Constant.itemsPerPage);
    listenToLocalMessages();
  }

  void initState() {
    data = data?.copyWith(isAdmin: _isConversationAdmin(data?.conversation));
  }

  Future<void> onLoadMore() async {
    Log.d('onLoadMore: ${oldestMessage?.uniqueId} - ${data?.conversation?.id}');
    if (oldestMessage == null) {
      return;
    }
    final messages = await _ref.firebaseFirestore.getOlderMessages(latestMessageId: oldestMessage!.uniqueId, conversationId: data?.conversation?.id);
    for (final x in messages) {
      Log.d('onLoadMore > messages: ${x.toJson()}');
    }
    final isLastPage = messages.length < Constant.itemsPerPage;
    await _ref.database.putMessages(messages.map((e) => e.toDataLocal(_ref.preferences, data?.conversation?.id ?? '')).toList());
    data = data?.copyWith(isLastPage: isLastPage);
  }

  void listenToLocalMessages() {
    _messagesSubscription?.cancel();
    _messagesSubscription = _ref.database.getMessagesStream(data?.conversation?.id ?? '').listen(
      (event) {
        Log.d('new local message event: $event');
        data = data?.copyWith(messages: event);
      },
      onError: (e) {
        Log.d('getNewLocalMessageStream error by $e');
      },
    );
  }

  void listenToMessagesFromFirestore(int limit) {
    _messagesFromFirestoreSubscription?.cancel();
    _messagesFromFirestoreSubscription = Rx.combineLatest(
      [
        _ref.firebaseFirestore.getMessagesStream(conversationId: data?.conversation?.id, limit: limit),
        _ref.connectivity.onConnectivityChanged,
      ],
      (values) {
        final newMessages = values.first as List<FirebaseMessageModel>;
        final isConnected = values[1] as bool;
        if (isConnected) {
          _ref.database.putMessages(newMessages.map((e) => e.toDataLocal(_ref.preferences, data?.conversation?.id ?? '')).toList());
        }
      },
    ).listen((event) {}, onError: (e) {
      Log.d('listenTomessagesFromFirestore error: $e');
    });
  }

  void listenToConversationDetail() {
    _conversationSubscription?.cancel();
    if (data?.conversation?.id?.isNullOrEmpty == true) return;
    _conversationSubscription = _ref.firebaseFirestore.getConversationDetailStream(data?.conversation?.id ?? '').listen(
      (event) {
        Log.d('getConversationDetailStream event: $event');
        if (event != null) {
          data = data?.copyWith(conversation: event, isAdmin: _isConversationAdmin(event));
        }
      },
      onError: (e) {
        Log.d('listenToConversationDetail error: $e');
      },
    );
  }

  @override
  void dispose() {
    _messagesFromFirestoreSubscription?.cancel();
    _messagesFromFirestoreSubscription = null;
    _messagesSubscription?.cancel();
    _messagesSubscription = null;
    _conversationSubscription?.cancel();
    _conversationSubscription = null;
    super.dispose();
  }

  Future<void> sendMessage({required String message, ReplyMessage? replyMessage}) async {
    await runSafe(
      handleLoading: false,
      action: () async {
        final latestMessageCreatedAt = latestMessage?.createdAt ?? 0;
        final currentUserId = _ref.preferences.userId;
        final conversationId = data?.conversation?.id ?? '';

        // if users adjust the past time -> adjust to the future to make the message is latest
        final now = max(clock.now().millisecondsSinceEpoch, latestMessageCreatedAt + 1);
        final messageId = _ref.firebaseFirestore.createMessageId(conversationId);

        final localMessage = LocalMessageData(
          conversationId: conversationId,
          senderId: currentUserId,
          message: message,
          type: FirebaseMessageType.text,
          status: FirebaseMessageStatus.sending,
          uniqueId: messageId,
          userId: currentUserId,
          createdAt: now,
          updatedAt: now,
          replyMessage: replyMessage != null
              ? LocalReplyMessageData(
                  userId: currentUserId,
                  repplyToMessageId: replyMessage.messageId,
                  type: FirebaseMessageType.fromChatViewMessageType(replyMessage.messageType),
                  repplyToMessage: replyMessage.message,
                  replyByUserId: currentUserId,
                  replyToUserId: replyMessage.replyTo,
                  conversationId: conversationId,
                )
              : null,
        );

        await _ref.database.putMessage(localMessage);

        await _ref.firebaseFirestore.createMessage(
          currentUserId: _ref.preferences.userId,
          conversationId: data?.conversation?.id ?? '',
          message: localMessage.toDataRemote(),
        );
      },
    );
  }

  Future<void> deleteConversation() async {
    await runSafe(
      action: () async {
        await _ref.share.deleteConversation(data?.conversation?.id);
        await _ref.nav.pop();
      },
    );
  }

  bool _isConversationAdmin(FirebaseConversationModel? conversation) {
    return conversation?.members?.firstOrNullWhere((element) => element.userId == _ref.preferences.userId)?.isConversationAdmin == true;
  }
}
