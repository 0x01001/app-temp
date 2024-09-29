import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
      return () {};
    }, []);

    Future<void> _onRefresh() async {
      // monitor network fetch
      Log.d('onRefresh');

      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    Future<void> _onLoadMore() async {
      // monitor network fetch
      Log.d('onLoadMore');

      _refreshController.loadComplete();
    }

    return AppScaffold(
      appBar: AppTopBar(text: 'Home'),
      body: Consumer(
        builder: (context, ref, child) {
          final users = ref.watch(provider.select((value) => value.data?.users));
          final isLoading = ref.watch(provider.select((value) => value.data?.isLoading));
          Log.d('HomePage > render > isLoading: $isLoading - ${users?.length} - ${context.colors.surface}');
          return AppRefresher(
            refreshController: _refreshController,
            onRefresh: _onRefresh,
            onLoadMore: _onLoadMore,
            child: isLoading == true && users?.isEmpty == true
                ? const _ListViewLoader()
                : AppListView(
                    type: AppListViewType.separated,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    items: users,
                    itemBuilder: (context, index) {
                      return ShimmerLoading(
                        loadingWidget: const _LoadingItem(),
                        isLoading: isLoading ?? false,
                        child: ListTile(
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
                        ),
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
