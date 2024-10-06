import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/index.dart';
import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class ConversationPage extends BasePage<ConversationState, AutoDisposeStateNotifierProvider<ConversationProvider, AppState<ConversationState>>> {
  const ConversationPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<ConversationProvider, AppState<ConversationState>> get provider => conversationProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    Log.d('ConversationPage > build');

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return () {};
    }, []);

    final email = ref.watch(currentUserProvider.select((value) => value.email));

    return AppScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: AppTopBar(enableSearchBar: true, text: S.current.conversation, titleSpacing: 0, onSearchBarChanged: (value) => ref.read(provider.notifier).setKeyWord(value ?? '')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isVipMember = ref.watch(currentUserProvider.select((value) => value.isVip));
                      return Row(
                        children: [
                          AppAvatar(text: email ?? ''),
                          const SizedBox(width: 16),
                          Flexible(child: AppText(email)),
                          const SizedBox(width: 4),
                          Visibility(
                            visible: isVipMember ?? false,
                            child: const Icon(Icons.local_police, size: 20, color: Colors.green),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
            child: Row(
              children: [
                const SizedBox(width: 12),
                AppText(S.current.conversation, type: TextType.title),
                const Spacer(),
                IconButton(icon: const Icon(Icons.add), onPressed: () => ref.nav.push(UserRoute(action: UserPageAction.createNewConversation))),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final dataConversations = ref.watch(filterConversationsProvider);
                // final total = ref.watch(provider.select((value) => value.data?.total));
                // final isLoading = ref.watch(provider.select((value) => value.data?.isLoading));
                // Log.d('ConversationPage > render: $isLoading - ${users?.length}');
                return AppListView(
                  type: AppListViewType.separated,
                  // isLoading: isLoading,
                  items: dataConversations,
                  // total: total,
                  itemBuilder: (_, index) => _Item(item: dataConversations?[index], index: index),
                  loadingWidget: const _LoadingWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends ConsumerWidget {
  const _Item({this.index, this.item});

  final int? index;
  final FirebaseConversationModel? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationName = ref.watch(conversationNameProvider(item?.id ?? ''));
    return InkWell(
      onTap: () {
        // ref.nav.push(ChatRoute(conversation: item));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          if (item != null) ref.read(conversationProvider.notifier).deleteConversation(item!);
        },
        confirmDismiss: (direction) async {
          return await ref.nav.showDialog(AppPopup.confirmDialog('Are you sure you want to delete this conversation?'));
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  AppAvatar(text: conversationName, width: 36, height: 36),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(conversationName),
                        if (item?.lastMessage?.isNotEmpty == true) AppText(item?.lastMessage),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: Constant.shimmerItemCount,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: RectangleShimmer(
            width: double.infinity,
            height: 72,
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ),
      ),
    );
  }
}
