import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

enum AppListViewType { none, separated }

class AppListView<T> extends HookConsumerWidget {
  const AppListView({
    this.itemBuilder,
    super.key,
    this.type = AppListViewType.none,
    this.shrinkWrap,
    this.padding,
    this.separatorBuilder,
    this.items = const [],
    this.physics,
    this.fetch,
    this.useRefresher = false,
    this.isLoading = false,
    this.loadingWidget,
    this.total = 0,
    this.itemsPerPage = Constant.itemsPerPage,
    this.scrollDirection,
    this.useAnimation = true,
  });

  final AppListViewType? type;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final IndexedWidgetBuilder? itemBuilder;
  final ScrollPhysics? physics;
  final Loader<T>? fetch;
  final List<T>? items;
  final bool? useRefresher;
  final bool? isLoading;
  final bool? useAnimation;
  final Widget? loadingWidget; // shimmer loading
  final int? total; // total of items
  final int? itemsPerPage;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useRef(RefreshController());
    final _page = useRef(Constant.initialPage);

    useEffect(() {
      Future.microtask(() {
        fetch?.call(isRefresh: true, page: _page.value, limit: itemsPerPage);
      });
      return null;
    }, []);

    Future<void> _onRefresh() async {
      Log.start('onRefresh');
      _page.value = Constant.initialPage;
      await fetch?.call(isRefresh: true, page: _page.value, limit: itemsPerPage);
      _controller.value.refreshCompleted(resetFooterState: true);
      Log.end('onRefresh > done');
    }

    Future<void> _onLoadMore() async {
      final count = items?.length ?? 0;
      Log.start('onLoadMore: $count - $total');
      if (count < (total ?? 0)) {
        _page.value++;
        await fetch?.call(isRefresh: false, page: _page.value, limit: itemsPerPage);
        _controller.value.loadComplete();
      } else {
        _controller.value.loadNoData();
      }
      Log.end('onLoadMore > done');
    }

    final listView = items?.isEmpty == true
        ? const AppNoData()
        : ListView.separated(
            scrollDirection: scrollDirection ?? Axis.vertical,
            physics: useRefresher == true ? const BouncingScrollPhysics() : physics,
            shrinkWrap: useRefresher ?? shrinkWrap ?? false,
            padding: padding ?? EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              if (useAnimation == true) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: 375.ms,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: itemBuilder?.call(context, index) ?? const SizedBox.shrink(),
                    ),
                  ),
                );
              }
              return itemBuilder?.call(context, index) ?? const SizedBox.shrink();
            },
            separatorBuilder: separatorBuilder ?? (_, __) => _SeparatorBuilder(type: type),
            itemCount: items?.length ?? 0,
          );
    final content = useAnimation == true ? AnimationLimiter(child: listView) : listView;

    return useRefresher == true
        ? AppRefresher(
            refreshController: _controller.value,
            onRefresh: _onRefresh,
            onLoadMore: _onLoadMore,
            child: isLoading == true ? loadingWidget ?? const SizedBox.shrink() : content,
          )
        : content;
  }
}

class _SeparatorBuilder extends StatelessWidget {
  const _SeparatorBuilder({this.type});

  final AppListViewType? type;

  @override
  Widget build(BuildContext context) {
    return type == AppListViewType.separated ? Divider(color: context.theme.dividerColor, height: Constant.borderHeight) : const SizedBox.shrink();
  }
}
