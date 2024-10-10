import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chatview/chatview.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

@RoutePage()
class ChatPage extends BasePage<ChatState, AutoDisposeStateNotifierProvider<ChatProvider, AppState<ChatState>>> {
  const ChatPage({required this.conversation, super.key});

  final FirebaseConversationModel conversation;

  @override
  AutoDisposeStateNotifierProvider<ChatProvider, AppState<ChatState>> get provider => chatProvider(conversation);

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final listMessages = ref.read(provider.select((value) => value.data?.messages));
    final currentUser = ref.watch(currentUserProvider.select((value) => value.toChatUser()));

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });

      return () {};
    }, []);

    final chatController = useMemoized(() => ChatController(
          scrollController: scrollController,
          initialMessageList: listMessages?.map((e) => e.toMessage()).toList() ?? [],
          currentUser: currentUser,
          otherUsers: conversation.members?.map((e) => e.toChatUser()).toList() ?? [],
        ));

    ref.listen(conversationMembersProvider(conversation.id ?? ''), (previous, next) {
      if (!next.isNullOrEmpty) {
        final members = next.map((e) => e.toChatUser()).toList();
        chatController.otherUsers = [...members, currentUser].distinctBy((element) => element.id).toList();
      }
    });

    ref.listen(provider.select((value) => value.data?.messages), (previous, next) {
      if (previous?.length != next?.length) {
        ref.read(provider.notifier).listenToMessagesFromFirestore(next?.length ?? 0);
      }

      chatController.initialMessageList = next?.map((e) => e.toMessage()).toList() ?? [];
    });

    final title = ref.watch(conversationNameProvider(conversation.id ?? ''));
    final isAdmin = ref.watch(provider.select((value) => value.data?.isAdmin));

    return AppScaffold(
      appBar: AppTopBar(
        text: title,
        actions: [
          if (isAdmin == true)
            IconButton(
              onPressed: () {
                final con = ref.read(provider.select((value) => value.data?.conversation));
                ref.nav.push(UserRoute(action: UserPageAction.addMembers, conversation: con));
              },
              icon: const Icon(Icons.group_add, color: Colors.black, size: 24),
            ),
        ],
      ),
      hideKeyboardWhenTouchOutside: true,
      body: ChatView(
        // currentUser: currentUser,
        chatController: chatController,
        loadingWidget: const SizedBox(
          height: 3,
          child: LinearProgressIndicator(backgroundColor: Colors.white, color: Colors.black),
        ),
        loadMoreData: ref.read(provider.notifier).onLoadMore,
        isLastPage: ref.watch(provider.select((value) => value.data?.isLastPage)),
        featureActiveConfig: featureActiveConfig(),
        chatViewState: chatViewState,
        chatViewStateConfig: chatViewStateConfig,
        chatBackgroundConfig: chatBackgroundConfig,
        sendMessageConfig: sendMessageConfig,
        chatBubbleConfig: chatBubbleConfig,
        replyPopupConfig: replyPopupConfig,
        repliedMessageConfig: repliedMessageConfig,
        swipeToReplyConfig: swipeToReplyConfig,

        // items: [
        //   MenuItem(
        //     text: l10n.renameConversationMembers,
        //     action: () async {
        //       await _showRenameConversation(ref);
        //     },
        //   ),
        //   MenuItem(
        //     text: l10n.deleteThisConversation,
        //     action: () async {
        //       final isConfirm = await ref.nav.showDialog(
        //             CommonPopup.confirmDialog(l10n.doYouWantToDeleteThisConversation),
        //           );
        //       if (isConfirm == true) {
        //         unawaited(ref.read(provider.notifier).deleteConversation());
        //       }
        //     },
        //   ),
        // ],
        onSendTap: (message, replyMessage, messageType) => ref.read(provider.notifier).sendMessage(
              message: message,
              replyMessage: replyMessage.message.isEmpty ? null : replyMessage,
            ),

        // onMoreMenuBuilder: (message, index) => MoreMenuIconButton(
        //   onCopy: () => Clipboard.setData(ClipboardData(text: message.message)),
        //   onReply: () => chatController.re .showReplyView(message),
        // ),
      ),
    );
  }

  FeatureActiveConfig featureActiveConfig() => const FeatureActiveConfig(
        lastSeenAgoBuilderVisibility: false,
        receiptsBuilderVisibility: true,
        enablePagination: true,
        enableSwipeToSeeTime: false,
        enableDoubleTapToLike: false,
        enableReactionPopup: false,
        enableChatSeparator: false,
        enableOtherUserProfileAvatar: false,
        enableCurrentUserProfileAvatar: false,
        enableReplySnackBar: false,
      );

  ChatViewState get chatViewState => ChatViewState.hasMessages;

  ChatViewStateConfiguration get chatViewStateConfig => const ChatViewStateConfiguration(
        loadingWidgetConfig: ChatViewStateWidgetConfiguration(
          loadingIndicatorColor: Colors.black,
        ),
      );

  ChatBackgroundConfiguration get chatBackgroundConfig => const ChatBackgroundConfiguration(
        backgroundColor: Colors.white,
      );

  SendMessageConfiguration get sendMessageConfig => const SendMessageConfiguration(
        textFieldBackgroundColor: Colors.grey,
        replyMessageColor: Colors.grey,
        replyDialogColor: Colors.black,
        // ignore: avoid_hard_coded_colors
        replyTitleColor: Colors.white,
        // ignore: avoid_hard_coded_colors
        closeIconColor: Colors.white,
        enableCameraImagePicker: false,
        allowRecordingVoice: false,
        enableGalleryImagePicker: false,
      );

  ChatBubbleConfiguration get chatBubbleConfig => const ChatBubbleConfiguration(
        outgoingChatBubbleConfig: ChatBubble(
          linkPreviewConfig: null,
          receiptsWidgetConfig: ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
          color: Colors.black,
          textStyle: TextStyle(color: Colors.white, fontSize: 14),
        ),
        inComingChatBubbleConfig: ChatBubble(
          linkPreviewConfig: null,
          textStyle: TextStyle(color: Colors.black, fontSize: 14),
          senderNameTextStyle: TextStyle(color: Colors.black, fontSize: 14),
          color: Colors.grey,
        ),
      );

  ReplyPopupConfiguration get replyPopupConfig => const ReplyPopupConfiguration(
        backgroundColor: Colors.black,
        buttonTextStyle: TextStyle(color: Colors.white, fontSize: 14),
        topBorderColor: Colors.black,
      );

  RepliedMessageConfiguration get repliedMessageConfig => const RepliedMessageConfiguration(
        backgroundColor: Colors.black,
        verticalBarColor: Colors.white,
        repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(
          enableHighlightRepliedMsg: true,
          highlightColor: Colors.red,
          highlightScale: 1.1,
        ),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.25,
        ),
        replyTitleTextStyle: TextStyle(color: Colors.white, fontSize: 14),
      );

  SwipeToReplyConfiguration get swipeToReplyConfig => const SwipeToReplyConfiguration(
        replyIconColor: Colors.white,
      );

  Future<void> _showRenameConversation(WidgetRef ref) async {
    // await ref.read(appNavigatorProvider).push(RenameConversationRoute(
    //       conversation: ref.read(provider.select((value) => value.data.conversation)),
    //     ));
  }
}
