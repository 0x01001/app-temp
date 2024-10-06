import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/index.dart';
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
  ChatProvider(this._ref, FirebaseConversationModel? conversation)
      : super(
          AppState(
            data: ChatState(conversation: conversation),
          ),
        );

  final Ref _ref;

  StreamSubscription<List<LocalMessageData>>? _messagesSubscription;
  StreamSubscription<void>? _messagesFromFirestoreSubscription;
  StreamSubscription<FirebaseConversationModel?>? _conversationSubscription;

  // LocalMessageData? get oldestMessage => data.messages?.lastOrNull;

  // LocalMessageData? get latestMessage => data.messages?.firstOrNull;

  void init() {
    // initState();
    // listenToConversationDetail();
    // listenToMessagesFromFirestore(Constant.itemsPerPage);
    // listenToLocalmessages();
  }

  // void initState() {
  //   data = data.copyWith(
  //     isAdmin: _isConversationAdmin(data.conversation),
  //   );
  // }

  // Future<void> onLoadMore() async {
  //   if (oldestMessage == null) {
  //     return;
  //   }

  //   final messages = await _ref.firebaseFirestoreService.getOlderMessages(
  //     latestMessageId: oldestMessage!.uniqueId,
  //     conversationId: data.conversation.id,
  //   );

  //   Log.d('load more firestore messages: $messages');

  //   final isLastPage = messages.length < Constant.itemsPerPage;

  //   await _ref.appDatabase.putMessages(_messageDataMapper.mapToLocalList(messages));

  //   data = data.copyWith(isLastPage: isLastPage);
  // }

  // void listenToLocalmessages() {
  //   _messagesSubscription?.cancel();
  //   _messagesSubscription = _ref.appDatabase.getMessagesStream(data.conversation.id).listen(
  //     (event) {
  //       logD('new local message event: $event');
  //       data = data.copyWith(messages: event);
  //     },
  //     onError: (e) {
  //       Log.d('getNewLocalMessageStream error by $e');
  //     },
  //   );
  // }

  // void listenToMessagesFromFirestore(int limit) {
  //   _messagesFromFirestoreSubscription?.cancel();
  //   _messagesFromFirestoreSubscription = Rx.combineLatest(
  //     [
  //       _ref.firebaseFirestoreService.getMessagesStream(
  //         conversationId: data.conversation.id,
  //         limit: limit,
  //       ),
  //       _ref.connectivityHelper.onConnectivityChanged,
  //     ],
  //     (values) {
  //       final newMessages = values.first as List<FirebaseMessageData>;
  //       final isConnected = values[1] as bool;

  //       if (isConnected) {
  //         _ref.appDatabase.putMessages(_messageDataMapper.mapToLocalList(newMessages));
  //       }
  //     },
  //   ).listen(
  //     (event) {},
  //     onError: (e) {
  //       Log.d('listenTomessagesFromFirestore error by $e');
  //     },
  //   );
  // }

  // void listenToConversationDetail() {
  //   _conversationSubscription?.cancel();
  //   _conversationSubscription = _ref.firebaseFirestoreService.getConversationDetailStream(data.conversation.id).listen(
  //     (event) {
  //       Log.d('getConversationDetailStream event: $event');
  //       if (event != null) {
  //         data = data.copyWith(
  //           conversation: event,
  //           isAdmin: _isConversationAdmin(event),
  //         );
  //       }
  //     },
  //     onError: (e) {
  //       Log.d('listenToConversationDetail error by $e');
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _messagesFromFirestoreSubscription?.cancel();
  //   _messagesFromFirestoreSubscription = null;
  //   _messagesSubscription?.cancel();
  //   _messagesSubscription = null;
  //   _conversationSubscription?.cancel();
  //   _conversationSubscription = null;
  //   super.dispose();
  // }

  // Future<void> sendMessage({
  //   required String message,
  //   ReplyMessage? replyMessage,
  // }) async {
  //   await runCatching(
  //     handleLoading: false,
  //     action: () async {
  //       final latestMessageCreatedAt = latestMessage?.createdAt ?? 0;
  //       final currentUserId = _ref.appPreferences.userId;
  //       final conversationId = data.conversation.id;

  //       // nếu users điều chỉnh giờ quá khứ -> điều chỉnh thành tương lai để tin nhắn là latest
  //       final now = max(clock.now().millisecondsSinceEpoch, latestMessageCreatedAt + 1);
  //       final messageId = _ref.firebaseFirestoreService.createMessageId(conversationId);

  //       final localMessage = LocalMessageData(
  //         conversationId: conversationId,
  //         senderId: currentUserId,
  //         message: message,
  //         type: MessageType.text,
  //         status: MessageStatus.sending,
  //         uniqueId: messageId,
  //         userId: currentUserId,
  //         createdAt: now,
  //         updatedAt: now,
  //         replyMessage: replyMessage != null
  //             ? LocalReplyMessageData(
  //                 userId: currentUserId,
  //                 repplyToMessageId: replyMessage.messageId,
  //                 type: MessageType.fromChatViewMessageType(replyMessage.messageType),
  //                 repplyToMessage: replyMessage.message,
  //                 replyByUserId: currentUserId,
  //                 replyToUserId: replyMessage.replyTo,
  //                 conversationId: conversationId,
  //               )
  //             : null,
  //       );

  //       await _ref.appDatabase.putMessage(localMessage);

  //       await _ref.firebaseFirestoreService.createMessage(
  //         currentUserId: _ref.appPreferences.userId,
  //         conversationId: data.conversation.id,
  //         message: _messageDataMapper.mapToRemote(localMessage),
  //       );
  //     },
  //   );
  // }

  // Future<void> deleteConversation() async {
  //   await runCatching(
  //     action: () async {
  //       await _ref.sharedViewModel.deleteConversation(data.conversation);
  //       await _ref.nav.pop();
  //     },
  //   );
  // }

  // bool _isConversationAdmin(FirebaseConversationData conversation) {
  //   return conversation.members.firstOrNullWhere((element) => element.userId == _ref.appPreferences.userId)?.isConversationAdmin == true;
  // }
}
