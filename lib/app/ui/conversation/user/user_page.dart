import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/index.dart';
import '../../../index.dart';

enum UserPageAction {
  createNewConversation,
  addMembers;

  String get title {
    switch (this) {
      case UserPageAction.createNewConversation:
        return 'Create A New Conversation';
      case UserPageAction.addMembers:
        return 'Add New Members';
    }
  }
}

@RoutePage()
class UserPage extends BasePage<UserState, AutoDisposeStateNotifierProvider<UserProvider, AppState<UserState>>> {
  const UserPage({required this.action, this.conversation, super.key});

  @override
  AutoDisposeStateNotifierProvider<UserProvider, AppState<UserState>> get provider => userProvider(conversation);

  final FirebaseConversationModel? conversation;
  final UserPageAction action;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return () {};
    }, []);

    return AppScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: AppTopBar(enableSearchBar: true, text: action.title, titleSpacing: 0, onSearchBarChanged: (value) => ref.read(provider.notifier).setKeyWord(value ?? '')),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final users = ref.watch(provider.select((value) => value.data?.filteredUsers));
              final members = ref.watch(provider.select((value) => value.data?.conversationUsers));
              final hasMembersTitle = members?.isNotEmpty ?? false;
              final hasUsersTitle = users?.isNotEmpty ?? false;
              final itemCount = (members?.length ?? 0) + (users?.length ?? 0) + (hasMembersTitle ? 1 : 0) + (hasUsersTitle ? 1 : 0);

              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  final hasMembersList = members?.isNotEmpty ?? false;
                  final isNotShowDivider = hasMembersList
                      ? () {
                          const membersTitleIndex = 0;
                          final usersTitleIndex = (members?.length ?? 0) + 1;
                          return index == membersTitleIndex || index == usersTitleIndex || index == (members?.length ?? 0);
                        }()
                      : index == 0;

                  return isNotShowDivider ? const SizedBox() : const SizedBox(height: 1, child: AppDivider(indent: 60));
                },
                padding: EdgeInsets.zero,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if ((members?.isNotEmpty ?? false) && index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: AppText('Members', type: TextType.title),
                    );
                  }

                  if ((users?.isNotEmpty ?? false) && index == ((members?.isEmpty ?? false) ? 0 : (members?.length ?? 0) + 1)) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: AppText('Users', type: TextType.title),
                    );
                  }

                  if ((members?.isNotEmpty ?? false) && index < (members?.length ?? 0) + 1) {
                    return _buildMemberItem(ref: ref, index: index - 1, users: members);
                  }

                  final membersItemCount = members?.length ?? 0;
                  final membersTitleItemCount = (members?.isNotEmpty ?? false) ? 1 : 0;
                  final usersTitleItemCount = (users?.isNotEmpty ?? false) ? 1 : 0;
                  final i = index - membersItemCount - membersTitleItemCount - usersTitleItemCount;

                  return _buildUserItem(ref: ref, index: i, users: users);
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Consumer(builder: (context, ref, child) {
                final isAddButtonEnabled = ref.watch(provider.select((value) => value.data?.isAddButtonEnabled));
                final _provider = ref.read(provider.notifier);

                return AppButton(
                  'Add',
                  onPressed: (isAddButtonEnabled ?? false) ? () => action == UserPageAction.createNewConversation ? _provider.createConversation() : _provider.addMembers() : null,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem({required WidgetRef ref, required int index, List<FirebaseConversationUserModel>? users}) {
    final user = users?[index];
    final userId = user?.userId;
    final email = user?.email;
    final isMe = userId == ref.watch(currentUserProvider.select((value) => value.id));
    final _provider = ref.read(provider.notifier);

    return InkWell(
      onTap: isMe
          ? null
          : () {
              final check = _provider.isConversationUserChecked(userId ?? '');
              check ? _provider.unselectConversationUser(userId ?? '') : _provider.selectConversationUser(userId ?? '');
            },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                AppCheckBox(
                  value: ref.watch(provider.notifier).isConversationUserChecked(userId ?? ''),
                  enabled: !isMe,
                  onChanged: (value) async => {
                    value == true ? _provider.selectConversationUser(userId ?? '') : _provider.unselectConversationUser(userId ?? ''),
                  },
                ),
                const SizedBox(width: 8),
                AppAvatar(text: email, width: 36, height: 36),
                const SizedBox(width: 16),
                Expanded(child: AppText('$email${isMe ? ' you' : ''}', type: TextType.title)),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUserItem({required WidgetRef ref, required int index, required List<FirebaseUserModel>? users}) {
    final userId = users?[index].id;
    final _provider = ref.read(provider.notifier);

    return InkWell(
      onTap: () {
        _provider.isUserChecked(userId ?? '') ? _provider.unselectUser(userId ?? '') : _provider.selectUser(userId ?? '');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                AppCheckBox(
                  value: ref.watch(provider.notifier).isUserChecked(userId ?? ''),
                  onChanged: (value) async => {
                    value == true ? _provider.selectUser(userId ?? '') : _provider.unselectUser(userId ?? ''),
                  },
                ),
                const SizedBox(width: 8),
                AppAvatar(text: users?[index].email, width: 36, height: 36),
                const SizedBox(width: 16),
                Expanded(child: AppText(users?[index].email ?? '', type: TextType.title)),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
