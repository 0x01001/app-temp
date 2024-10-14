import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chatview/chatview.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/index.dart';
import '../../../../resources/index.dart';
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
    // final listMessages = ref.read(provider.select((value) => value.data?.messages));
    final currentUser = ref.watch(currentUserProvider.select((value) => value.toChatUser()));
    final isDarkTheme = ref.watch(isDarkModeProvider);
    final title = ref.watch(conversationNameProvider(conversation.id ?? ''));
    // final isAdmin = ref.watch(provider.select((value) => value.data?.isAdmin));
    final theme = isDarkTheme == true ? DarkTheme() : LightTheme();
    const profileImage = 'https://raw.githubusercontent.com/SimformSolutionsPvtLtd/flutter_showcaseview/master/example/assets/simform.png';
    Log.d('currentUser: ${currentUser.id}');
    // Log.d('listMessages: ${listMessages?.length}');
    Log.d('members: ${conversation.members?.length}');
    Log.d('conversation: ${conversation.toJson()}');

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return null;
    }, []);

    // final messageList = [
    //   Message(
    //       id: '1',
    //       message: 'Hi!',
    //       createdAt: DateTime.now(),
    //       sentBy: '1', // userId of who sends the message
    //       status: MessageStatus.read),
    //   Message(id: '2', message: 'Hi!', createdAt: DateTime.now(), sentBy: '2', status: MessageStatus.read),
    //   Message(id: '3', message: 'We can meet?I am free', createdAt: DateTime.now(), sentBy: '1', status: MessageStatus.read),
    //   Message(id: '4', message: 'Can you write the time and place of the meeting?', createdAt: DateTime.now(), sentBy: '1', status: MessageStatus.read),
    //   Message(id: '5', message: "That's fine", createdAt: DateTime.now(), sentBy: '2', reaction: Reaction(reactions: ['\u{2764}'], reactedUserIds: ['1']), status: MessageStatus.read),
    //   Message(id: '6', message: 'When to go ?', createdAt: DateTime.now(), sentBy: '3', status: MessageStatus.read),
    //   Message(id: '7', message: 'I guess Simform will reply', createdAt: DateTime.now(), sentBy: '4', status: MessageStatus.read),
    //   Message(
    //     id: '8',
    //     message: 'https://bit.ly/3JHS2Wl',
    //     createdAt: DateTime.now(),
    //     sentBy: '2',
    //     reaction: Reaction(
    //       reactions: ['\u{2764}', '\u{1F44D}', '\u{1F44D}'],
    //       reactedUserIds: ['2', '3', '4'],
    //     ),
    //     status: MessageStatus.read,
    //     replyMessage: const ReplyMessage(
    //       message: 'Can you write the time and place of the meeting?',
    //       replyTo: '1',
    //       replyBy: '2',
    //       messageId: '4',
    //     ),
    //   ),
    //   Message(
    //     id: '9',
    //     message: 'Done',
    //     createdAt: DateTime.now(),
    //     sentBy: '1',
    //     status: MessageStatus.read,
    //     reaction: Reaction(
    //       reactions: [
    //         '\u{2764}',
    //         '\u{2764}',
    //         '\u{2764}',
    //       ],
    //       reactedUserIds: ['2', '3', '4'],
    //     ),
    //   ),
    //   Message(
    //     id: '10',
    //     message: 'Thank you!!',
    //     status: MessageStatus.read,
    //     createdAt: DateTime.now(),
    //     sentBy: '1',
    //     reaction: Reaction(
    //       reactions: ['\u{2764}', '\u{2764}', '\u{2764}', '\u{2764}'],
    //       reactedUserIds: ['2', '4', '3', '1'],
    //     ),
    //   ),
    //   Message(id: '11', message: 'https://miro.medium.com/max/1000/0*s7of7kWnf9fDg4XM.jpeg', createdAt: DateTime.now(), messageType: MessageType.image, sentBy: '1', reaction: Reaction(reactions: ['\u{2764}'], reactedUserIds: ['2']), status: MessageStatus.read),
    //   Message(id: '12', message: '🤩🤩', createdAt: DateTime.now(), sentBy: '2', status: MessageStatus.read),
    // ];

    final chatController = ChatController(
      scrollController: ScrollController(),
      initialMessageList: ref.read(provider.select((value) => value.data?.messages))?.map((e) => e.toMessage()).toList() ?? [],
      currentUser: currentUser,
      otherUsers: conversation.members?.map((e) => e.toChatUser()).toList() ?? [],
    );

    ref.listen(conversationMembersProvider(conversation.id ?? ''), (previous, next) {
      if (!next.isNullOrEmpty) {
        final members = next.map((e) => e.toChatUser()).toList();
        chatController.otherUsers = [...members, currentUser].distinctBy((element) => element.id).toList();
        Log.d('[Listen] conversation.id > other user: ${chatController.otherUsers.length}');
      }
    });

    ref.listen(provider.select((value) => value.data?.messages), (previous, next) {
      if (previous?.length != next?.length) {
        ref.read(provider.notifier).listenToMessagesFromFirestore(next?.length ?? 0);
      }
      final list = next?.map((e) => e.toMessage()).reversed.toList() ?? [];
      Log.d('[Listen] messages changed: ${list.length}');
      if (listEquals(chatController.initialMessageList, list)) {
        Log.e('-------------- initialMessageList is same list --------------');
        return;
      }
      chatController.initialMessageList = list;
      chatController.messageStreamController.sink.add(chatController.initialMessageList);
    });

    Future<void> _onSendTap(String message, ReplyMessage replyMessage, MessageType messageType) async {
      await ref.read(provider.notifier).sendMessage(message: message);
      Future.delayed(300.ms, () {
        chatController.initialMessageList.last.setStatus = MessageStatus.undelivered;
      });
      Future.delayed(800.ms, () {
        chatController.initialMessageList.last.setStatus = MessageStatus.read;
      });
    }

    ScrollToBottomButtonConfig scrollToBottomButtonConfig() => ScrollToBottomButtonConfig(
          backgroundColor: theme.textFieldBackgroundColor,
          border: Border.all(color: isDarkTheme == true ? Colors.transparent : Colors.grey),
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.themeIconColor, weight: 10, size: 30),
        );

    ChatViewStateConfiguration chatViewStateConfig() => ChatViewStateConfiguration(
          loadingWidgetConfig: ChatViewStateWidgetConfiguration(loadingIndicatorColor: theme.outgoingChatBubbleColor),
          onReloadButtonTap: () {},
        );

    ChatBackgroundConfiguration chatBackgroundConfig() => ChatBackgroundConfiguration(
          messageTimeIconColor: theme.messageTimeIconColor,
          messageTimeTextStyle: TextStyle(color: theme.messageTimeTextColor),
          defaultGroupSeparatorConfig: DefaultGroupSeparatorConfiguration(
            textStyle: TextStyle(color: theme.chatHeaderColor, fontSize: 17),
          ),
          backgroundColor: theme.backgroundColor,
        );

    FeatureActiveConfig featureActiveConfig() => const FeatureActiveConfig(
          enableScrollToBottomButton: true,
          receiptsBuilderVisibility: true,
          enablePagination: true,
          enableSwipeToReply: true,

          // lastSeenAgoBuilderVisibility: false,
          // enableSwipeToSeeTime: false,
          // enableDoubleTapToLike: false,
          // enableReactionPopup: false,
          // enableChatSeparator: false,
          // enableOtherUserProfileAvatar: false,
          // enableCurrentUserProfileAvatar: false,
          // enableReplySnackBar: false,
        );

    SendMessageConfiguration sendMessageConfig() => SendMessageConfiguration(
          imagePickerIconsConfig: ImagePickerIconsConfiguration(cameraIconColor: theme.cameraIconColor, galleryIconColor: theme.galleryIconColor),
          replyMessageColor: theme.replyMessageColor,
          defaultSendButtonColor: theme.sendButtonColor,
          replyDialogColor: theme.replyDialogColor,
          replyTitleColor: theme.replyTitleColor,
          textFieldBackgroundColor: theme.textFieldBackgroundColor,
          closeIconColor: theme.closeIconColor,
          textFieldConfig: TextFieldConfiguration(
            onMessageTyping: (status) {
              /// Do with status
              debugPrint(status.toString());
            },
            compositionThresholdTime: const Duration(seconds: 1),
            textStyle: TextStyle(color: theme.textFieldTextColor),
          ),
          micIconColor: theme.replyMicIconColor,
          voiceRecordingConfiguration: VoiceRecordingConfiguration(
            backgroundColor: theme.waveformBackgroundColor,
            recorderIconColor: theme.recordIconColor,
            waveStyle: WaveStyle(showMiddleLine: false, waveColor: theme.waveColor ?? Colors.white, extendWaveform: true),
          ),
        );

    ChatBubbleConfiguration chatBubbleConfig() => ChatBubbleConfiguration(
          outgoingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              backgroundColor: theme.linkPreviewOutgoingChatColor,
              bodyStyle: theme.outgoingChatLinkBodyStyle,
              titleStyle: theme.outgoingChatLinkTitleStyle,
            ),
            receiptsWidgetConfig: const ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
            color: theme.outgoingChatBubbleColor,
          ),
          inComingChatBubbleConfig: ChatBubble(
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(color: theme.inComingChatBubbleTextColor, decoration: TextDecoration.underline),
              backgroundColor: theme.linkPreviewIncomingChatColor,
              bodyStyle: theme.incomingChatLinkBodyStyle,
              titleStyle: theme.incomingChatLinkTitleStyle,
            ),
            textStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            color: theme.inComingChatBubbleColor,
          ),
        );

    ReplyPopupConfiguration replyPopupConfig() => ReplyPopupConfiguration(
          backgroundColor: theme.replyPopupColor,
          buttonTextStyle: TextStyle(color: theme.replyPopupButtonColor),
          topBorderColor: theme.replyPopupTopBorderColor,
        );

    ReactionPopupConfiguration reactionPopupConfig() => ReactionPopupConfiguration(
          emojiConfig: const EmojiConfiguration(emojiList: ['\u{2764}', '\u{1F602}', '\u{1F625}', '\u{1F621}', '\u{1F632}', '\u{1F44D}'], size: 24),
          glassMorphismConfig: const GlassMorphismConfiguration(backgroundColor: Colors.white, borderRadius: 14, borderColor: Colors.white, strokeWidth: 4),
          shadow: BoxShadow(color: Colors.grey.shade400, blurRadius: 20),
          backgroundColor: theme.reactionPopupColor,
          userReactionCallback: (emoji, messageId) => chatController.setReaction(emoji: emoji.id, messageId: messageId, userId: currentUser.id),
        );

    RepliedMessageConfiguration repliedMessageConfig() => RepliedMessageConfiguration(
          backgroundColor: theme.repliedMessageColor,
          verticalBarColor: theme.verticalBarColor,
          repliedMsgAutoScrollConfig: RepliedMsgAutoScrollConfig(enableHighlightRepliedMsg: true, highlightColor: Colors.pinkAccent.shade100, highlightScale: 1.1),
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.25),
          replyTitleTextStyle: TextStyle(color: theme.repliedTitleTextColor),
        );

    SwipeToReplyConfiguration swipeToReplyConfig() => SwipeToReplyConfiguration(
          replyIconColor: theme.swipeToReplyIconColor,
        );
    ReplySuggestionsConfig replySuggestionsConfig() => ReplySuggestionsConfig(
          itemConfig: SuggestionItemConfig(
            decoration: BoxDecoration(
              color: theme.textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.outgoingChatBubbleColor ?? Colors.white),
            ),
            textStyle: TextStyle(color: isDarkTheme == true ? Colors.white : Colors.black),
          ),
          onTap: (item) => _onSendTap(item.text, const ReplyMessage(), MessageType.text),
        );

    MessageConfiguration messageConfig() => MessageConfiguration(
          messageReactionConfig: MessageReactionConfiguration(
            backgroundColor: theme.messageReactionBackGroundColor,
            borderColor: theme.messageReactionBackGroundColor,
            reactedUserCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionCountTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
            reactionsBottomSheetConfig: ReactionsBottomSheetConfiguration(
              backgroundColor: theme.backgroundColor,
              reactedUserTextStyle: TextStyle(color: theme.inComingChatBubbleTextColor),
              reactionWidgetDecoration: BoxDecoration(
                color: theme.inComingChatBubbleColor,
                boxShadow: [BoxShadow(color: isDarkTheme == true ? Colors.black12 : Colors.grey.shade200, offset: const Offset(0, 20), blurRadius: 40)],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          imageMessageConfig: ImageMessageConfiguration(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            shareIconConfig: ShareIconConfiguration(defaultIconBackgroundColor: theme.shareIconBackgroundColor, defaultIconColor: theme.shareIconColor),
          ),
        );

    ChatViewAppBar appBar() => ChatViewAppBar(
          elevation: theme.elevation,
          backGroundColor: theme.appBarColor,
          profilePicture: profileImage,
          backArrowColor: theme.backArrowColor,
          chatTitle: title,
          chatTitleTextStyle: TextStyle(color: theme.appBarTitleTextStyle, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.25),
          userStatus: 'online',
          userStatusTextStyle: const TextStyle(color: Colors.grey),
          actions: [
            IconButton(
              tooltip: 'Rename conversation members',
              onPressed: () async {
                // await ref.nav.push(RenameConversationRoute(
                //   conversation: ref.read(provider.select((value) => value.data?.conversation)),
                // ));
              },
              icon: Icon(Icons.edit, color: theme.themeIconColor),
            ),
            IconButton(
              tooltip: 'Delete this conversation',
              onPressed: () async {
                final isConfirm = await ref.nav.showDialog(AppPopup.confirmDialog('Confirm', message: 'Do you want to delete this conversation?'));
                if (isConfirm == true) {
                  unawaited(ref.read(provider.notifier).deleteConversation());
                }
              },
              icon: Icon(Icons.delete, color: theme.themeIconColor),
            ),
            // if (isAdmin == true)
            //   IconButton(
            //     tooltip: 'Add members to this conversation',
            //     onPressed: () {
            //       final con = ref.read(provider.select((value) => value.data?.conversation));
            //       ref.nav.push(UserRoute(action: UserPageAction.addMembers, conversation: con));
            //     },
            //     icon: const Icon(Icons.group_add, size: 24),
            //   ),
          ],
        );

    return AppScaffold(
      hideKeyboardWhenTouchOutside: true,
      body: ChatView(
        chatController: chatController,
        loadingWidget: const SizedBox(height: 2, child: LinearProgressIndicator(backgroundColor: Colors.white, color: Colors.black)),
        loadMoreData: () => ref.read(provider.notifier).onLoadMore(),
        isLastPage: ref.watch(provider.select((value) => value.data?.isLastPage)),
        featureActiveConfig: featureActiveConfig(),
        chatViewState: ChatViewState.hasMessages,
        chatViewStateConfig: chatViewStateConfig(),
        chatBackgroundConfig: chatBackgroundConfig(),
        sendMessageConfig: sendMessageConfig(),
        chatBubbleConfig: chatBubbleConfig(),
        replyPopupConfig: replyPopupConfig(),
        repliedMessageConfig: repliedMessageConfig(),
        swipeToReplyConfig: swipeToReplyConfig(),
        reactionPopupConfig: reactionPopupConfig(),
        messageConfig: messageConfig(),
        profileCircleConfig: const ProfileCircleConfiguration(profileImageUrl: profileImage),
        replySuggestionsConfig: replySuggestionsConfig(),
        scrollToBottomButtonConfig: scrollToBottomButtonConfig(),
        typeIndicatorConfig: TypeIndicatorConfiguration(
          flashingCircleBrightColor: theme.flashingCircleBrightColor,
          flashingCircleDarkColor: theme.flashingCircleDarkColor,
        ),
        appBar: appBar(),
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
}
