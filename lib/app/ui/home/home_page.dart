import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class HomePage extends BasePage<HomeState, AutoDisposeStateNotifierProvider<HomeProvider, AppState<HomeState>>> {
  const HomePage({super.key});

  @override
  AutoDisposeStateNotifierProvider<HomeProvider, AppState<HomeState>> get provider => homeProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    Log.d('HomePage > build');
    final _refreshController = RefreshController();

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return null;
    }, []);

    Future<void> _onRefresh() async {
      Log.d('onRefresh');
      await ref.read(provider.notifier).loadData(isRefresh: true);
      _refreshController.refreshCompleted(resetFooterState: true);
    }

    Future<void> _onLoadMore() async {
      final p = ref.read(provider.notifier);
      final count = p.state.data?.users?.length ?? 0;
      final total = p.state.data?.total ?? 0;
      Log.d('onLoadMore: $count - $total');
      if (count < total) {
        await p.loadMore();
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    }

    return AppScaffold(
      appBar: AppTopBar(text: S.current.home),
      body: Consumer(
        builder: (context, ref, child) {
          final users = ref.watch(provider.select((value) => value.data?.users));
          final isLoading = ref.watch(provider.select((value) => value.data?.isLoading));
          Log.d('HomePage > render: $isLoading - ${users?.length}');
          return AppRefresher(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoadMore: _onLoadMore,
            child: isLoading == true
                ? const _ListViewLoader()
                : AppListView(
                    type: AppListViewType.separated,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    items: users,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: context.colors.primary, width: 1.0),
                          ),
                          child: ClipOval(child: AppImage(users?[index].picture ?? '')),
                        ),
                        title: AppText('${users?[index].title?.toCapitalized()} ${users?[index].firstName} ${users?[index].lastName}', type: TextType.title),
                        subtitle: AppText(users?[index].id ?? ''),
                        onTap: () => Log.d('onTap: ${users?[index].id}'),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return const RectangleShimmer(width: double.infinity, height: 60);
  }
}

class _ListViewLoader extends StatelessWidget {
  const _ListViewLoader();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Constant.shimmerItemCount,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: ShimmerLoading(
          loadingWidget: _LoadingItem(),
          isLoading: true,
          child: _LoadingItem(),
        ),
      ),
    );
  }
}
