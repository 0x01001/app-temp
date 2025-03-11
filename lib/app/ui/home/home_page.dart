import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/user_model.dart';
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
    final _provider = ref.read(provider.notifier);

    Future<void> _loadData() async {
      return Future.microtask(() async {
        await _provider.loadData(isRefresh: true);
      });
    }

    useEffect(() {
      _loadData();
      return () {};
    }, []);

    return AppScaffold(
      appBar: AppTopBar(text: S.current.home),
      body: Consumer(
        builder: (context, ref, child) {
          final users = ref.watch(provider.select((value) => value.data?.users));
          final total = ref.watch(provider.select((value) => value.data?.total));
          final isLoading = ref.watch(provider.select((value) => value.data?.isLoading));
          Log.d('HomePage > render: $isLoading - ${users?.length}');
          return AppListView(
            useRefresher: true,
            isLoading: isLoading,
            padding: const EdgeInsets.symmetric(vertical: 4),
            items: users,
            total: total,
            itemBuilder: (_, index) => _Item(item: users?[index], index: index),
            loadingWidget: const AppLoadingShimmer(type: LoadingShimmerType.newData),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({this.index, this.item});

  final int? index;
  final UserModel? item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.colorScheme.primary, width: 1.0)),
          child: ClipOval(child: AppImage(item?.picture ?? '')),
        ),
        title: AppText('${item?.title?.toCapitalized()} ${item?.firstName} ${item?.lastName}', type: TextType.title),
        subtitle: AppText(item?.id ?? ''),
        onTap: () => Log.d('onTap: ${item?.id}'),
      ),
    );
  }
}
