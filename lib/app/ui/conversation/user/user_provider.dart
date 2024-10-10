import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

class UserState extends BaseState {
  UserState({this.isLoading = true, this.total, this.keyword, this.conversationUsers = const [], this.allUsersExceptMembers = const [], this.selectedUsers = const [], this.selectedConversationUsers = const []});

  bool? isLoading;
  int? total;
  String? keyword;
  List<FirebaseConversationUserModel>? conversationUsers;
  List<FirebaseUserModel>? allUsersExceptMembers;
  List<String>? selectedUsers;
  List<String?>? selectedConversationUsers;

  UserState copyWith({
    bool? isLoading,
    int? total,
    String? keyword,
    List<FirebaseConversationUserModel>? conversationUsers,
    List<FirebaseUserModel>? allUsersExceptMembers,
    List<String>? selectedUsers,
    List<String?>? selectedConversationUsers,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      total: total ?? this.total,
      keyword: keyword ?? this.keyword,
      conversationUsers: conversationUsers ?? this.conversationUsers,
      allUsersExceptMembers: allUsersExceptMembers ?? this.allUsersExceptMembers,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      selectedConversationUsers: selectedConversationUsers ?? this.selectedConversationUsers,
    );
  }

  List<FirebaseUserModel>? get filteredUsers {
    return allUsersExceptMembers?.filter((x) => x.email?.containsIgnoreCase(keyword ?? '') ?? false).toList();
  }

  bool get isAddButtonEnabled => selectedUsers?.isNotEmpty == true || selectedConversationUsers?.isNotEmpty == true;
}

final userProvider = StateNotifierProvider.autoDispose.family<UserProvider, AppState<UserState>, FirebaseConversationModel?>(
  (ref, conversation) => UserProvider(conversation, ref),
);

class UserProvider extends BaseProvider<UserState> {
  UserProvider(this._conversation, this._ref) : super(AppState(data: UserState()));

  final Ref _ref;
  final FirebaseConversationModel? _conversation;
  StreamSubscription<List<FirebaseUserModel>>? _usersSubscription;

  void init() {
    final initialMembers = _conversation?.members ?? [];
    final selectedConversationUsers = initialMembers.map((e) => e.userId).toList();
    data = data?.copyWith(
      conversationUsers: _conversation == null ? [] : _ref.share.getRenamedMembers(members: initialMembers, conversationId: _conversation.id),
      selectedConversationUsers: selectedConversationUsers,
    );
    listenToUsers(selectedConversationUsers);
  }

  @override
  void dispose() {
    _usersSubscription?.cancel();
    _usersSubscription = null;
    super.dispose();
  }

  void listenToUsers(List<String?> selectedUsers) {
    _usersSubscription?.cancel();
    _usersSubscription = _ref.firebaseFirestore.getUsersExceptMembersStream(selectedUsers.isNotEmpty == true ? selectedUsers : [_ref.preferences.userId]).listen(
      (users) {
        data = data?.copyWith(allUsersExceptMembers: users);
      },
    );
  }

  bool isUserChecked(String userId) {
    return data?.selectedUsers?.contains(userId) == true;
  }

  bool isConversationUserChecked(String userId) {
    return data?.selectedConversationUsers?.contains(userId) == true;
  }

  void selectUser(String userId) {
    data = data?.copyWith(selectedUsers: data?.selectedUsers?.plus(userId));
  }

  void unselectUser(String userId) {
    final newList = data?.selectedUsers?.minus(userId);
    data = data?.copyWith(selectedUsers: newList);
  }

  void selectConversationUser(String userId) {
    data = data?.copyWith(
      selectedConversationUsers: data?.selectedConversationUsers?.plus(userId),
    );
  }

  void unselectConversationUser(String userId) {
    final newList = data?.selectedConversationUsers?.minus(userId);
    data = data?.copyWith(selectedConversationUsers: newList);
  }

  Future<void> createConversation() async {
    await runSafe(action: () async {
      final membersExceptMe = data?.allUsersExceptMembers?.filter((element) => data?.selectedUsers?.contains(element.id) == true).toList() ?? [];
      final currentUserId = _ref.preferences.userId;
      final me = FirebaseUserModel(id: currentUserId, email: _ref.preferences.email);
      final users = [me, ...membersExceptMe].distinctBy((e) => e.id);
      final members = users.map((e) => FirebaseConversationUserModel(userId: e.id, email: AppUtils.randomName(), isConversationAdmin: e.id == currentUserId)).toList();
      final conversation = await _ref.firebaseFirestore.createConversation(members);
      await _ref.nav.popAndPush(ChatRoute(conversation: conversation));
    });
  }

  Future<void> addMembers() async {
    if (_conversation == null) {
      return;
    }

    await runSafe(action: () async {
      final currentId = _ref.preferences.userId;
      final currentMembers = data?.conversationUsers?.filter((element) => data?.selectedConversationUsers?.contains(element.userId) == true).toList() ?? [];
      final newMembers = data?.allUsersExceptMembers?.filter((element) => data?.selectedUsers?.contains(element.id) == true).toList() ?? [];
      final list1 = currentMembers.map((e) => FirebaseConversationUserModel(userId: e.userId, email: e.email, isConversationAdmin: e.userId == currentId));
      final list2 = newMembers.map((e) => FirebaseConversationUserModel(userId: e.id, email: AppUtils.randomName(), isConversationAdmin: false));
      final newList = [...list1, ...list2].distinctBy((e) => e.userId).toList();
      await _ref.firebaseFirestore.addMembers(conversationId: _conversation.id ?? '', members: newList);
      await _ref.nav.pop();
    });
  }

  void setKeyWord(String keyword) {
    data = data?.copyWith(keyword: keyword.trim());
  }
}
