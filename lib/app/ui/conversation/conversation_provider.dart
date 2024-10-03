import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class ConversationState extends BaseState {
  ConversationState({this.isLoading = true, this.total, this.keyword, this.conversationList = const []});

  bool? isLoading; // for shimmer
  int? total;
  String? keyword; // for search conversations
  List<FirebaseConversationModel>? conversationList;

  ConversationState copyWith({bool? isLoading, List<UserModel>? users, int? total, String? keyword, List<FirebaseConversationModel>? conversationList}) {
    return ConversationState(
      isLoading: isLoading ?? this.isLoading,
      total: total ?? this.total,
      keyword: keyword ?? this.keyword,
      conversationList: conversationList ?? this.conversationList,
    );
  }
}

final conversationProvider = StateNotifierProvider.autoDispose<ConversationProvider, AppState<ConversationState>>((ref) => ConversationProvider(ref));

class ConversationProvider extends BaseProvider<ConversationState> {
  ConversationProvider(this._ref) : super(AppState(data: ConversationState()));

  final Ref _ref;
  StreamSubscription<List<FirebaseConversationModel>>? _conversationsSubscription;

  Future<void> init() async {
    Log.d('ConversationProvider > init');
    listenToConversations();
  }

  void listenToConversations() {
    _conversationsSubscription?.cancel();
    final userId = _ref.preferences.userId;
    _conversationsSubscription = _ref.firebaseFirestore.getConversationsStream(userId).listen((event) {
      runSafe(
        action: () async {
          data = data?.copyWith(conversationList: event);
          // _ref.read(conversationMembersProvider.notifier).update((state) => state.plusAll(mergeConversationMembers(event)));
          _ref.update(conversationMembersProvider, (state) => state.plusAll(mergeConversationMembers(event)));
        },
        handleLoading: false,
      );
    });
  }

  Map<String, List<FirebaseConversationUserModel>> mergeConversationMembers(List<FirebaseConversationModel> conversations) {
    return conversations.associate((x) => MapEntry(
          x.id ?? '',
          _ref.share.getRenamedMembers(members: x.members ?? [], conversationId: x.id ?? '') ?? [],
        ));
  }

  void setKeyWord(String keyword) {
    data = data?.copyWith(keyword: keyword.trim());
  }

  Future<void> deleteConversation(FirebaseConversationModel conversation) async {
    data = data?.copyWith(conversationList: data?.conversationList?.minus(conversation));
    await runSafe(
      action: () async {
        await deleteConversationLocal(conversation.id ?? '');
      },
      onError: (e) async {
        data = data?.copyWith(conversationList: data?.conversationList?.plus(conversation));
      },
      handleLoading: false,
    );
  }

  Future<void> deleteConversationLocal(String conversationId) async {
    await _ref.firebaseFirestore.deleteConversation(conversationId);
    await _ref.database.removeMessagesByConversationId(conversationId);
  }

  @override
  void dispose() {
    _conversationsSubscription?.cancel();
    _conversationsSubscription = null;
    super.dispose();
  }
}
