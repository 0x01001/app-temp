import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

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
    this.onRefresh,
    this.onLoadMore,
    this.onReload,
    this.useRefresher = false,
    this.isLoading = false,
    this.loadingWidget,
    this.noDataWidget,
    this.total = 0,
    this.itemsPerPage = Constant.itemsPerPage,
    this.scrollDirection,
    this.useAnimation = true,
    this.useSliverList = false,
    this.listController,
    this.controller,
  });

  final AppListViewType? type;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final IndexedWidgetBuilder? separatorBuilder;
  final IndexedWidgetBuilder? itemBuilder;
  final ScrollPhysics? physics;
  final Future<void> Function(int? page)? onRefresh;
  final Future<void> Function(int? page)? onReload;
  final Future<void> Function(int? page)? onLoadMore;
  final List<T>? items;
  final bool? useRefresher;
  final bool? isLoading;
  final bool? useAnimation;
  final Widget? loadingWidget; // shimmer loading
  final Widget? noDataWidget;
  final int? total; // total of items
  final int? itemsPerPage;
  final Axis? scrollDirection;
  final bool? useSliverList;
  final ListController? listController;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useRef(RefreshController());
    final _page = useRef(Constant.initialPage);

    Future<void> _onReload() async {
      Log.start('onReload');
      _page.value = Constant.initialPage;
      await onReload?.call(_page.value);
      _controller.value.refreshCompleted(resetFooterState: true);
      Log.end('onReload > done');
    }

    useEffect(() {
      Future.microtask(() {
        onRefresh?.call(_page.value);
      });
      if (onReload != null) {
        ref.listenManual(showKeyboardProvider, (previous, next) {
          if (!next && context.mounted) {
            _onReload();
          }
        }, fireImmediately: true);
      }
      return null;
    }, []);

    Future<void> _onRefresh() async {
      Log.start('onRefresh');
      _page.value = Constant.initialPage;
      await onRefresh?.call(_page.value);
      _controller.value.refreshCompleted(resetFooterState: true);
      Log.end('onRefresh > done');
    }

    Future<void> _onLoadMore() async {
      final count = items?.length ?? 0;
      Log.start('onLoadMore: $count - $total');
      if (count < (total ?? 0)) {
        try {
          _page.value++;
          await onLoadMore?.call(_page.value);
          _controller.value.loadComplete();
        } catch (e) {
          Log.d('onLoadMore > error: $e');
          _page.value--;
        } finally {
          Log.end('onLoadMore > done');
        }
      } else {
        _controller.value.loadNoData();
      }
    }

    final listView = SuperListView.separated(
      key: key,
      controller: controller,
      listController: listController,
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: useRefresher == true ? const BouncingScrollPhysics() : physics,
      shrinkWrap: useRefresher ?? shrinkWrap ?? false, // note: shrinkWrap must be true when useRefresher is true
      padding: padding ?? EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) => _ItemBuilder(index: index, useAnimation: useAnimation, itemBuilder: itemBuilder),
      separatorBuilder: separatorBuilder ?? (_, __) => _SeparatorBuilder(type: type),
      itemCount: items?.length ?? 0,
    );
    final sliverList = SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SuperSliverList.builder(
        key: key,
        listController: listController,
        itemBuilder: (BuildContext context, int index) => _ItemBuilder(index: index, useAnimation: useAnimation, itemBuilder: itemBuilder),
        itemCount: items?.length ?? 0,
      ),
    );
    final list = items == null || items?.isEmpty == true ? _BoxBuilder(useSliverList: useSliverList, child: noDataWidget ?? const AppNoData()) : (useSliverList == true ? sliverList : listView);

    final content = isLoading == true ? (loadingWidget ?? _BoxBuilder(useSliverList: useSliverList)) : (useAnimation == true ? AnimationLimiter(child: list) : list);
    return useRefresher == true
        ? AppRefresher(
            refreshController: _controller.value,
            onRefresh: _onRefresh,
            onLoadMore: _onLoadMore,
            child: content,
          )
        : content;
  }
}

class _BoxBuilder extends StatelessWidget {
  const _BoxBuilder({this.child, this.useSliverList});

  final Widget? child;
  final bool? useSliverList;

  @override
  Widget build(BuildContext context) {
    return useSliverList == true ? SliverToBoxAdapter(child: child) : child ?? const SizedBox.shrink();
  }
}

class _ItemBuilder extends StatelessWidget {
  const _ItemBuilder({required this.index, this.useAnimation, this.itemBuilder});

  final int index;
  final bool? useAnimation;
  final IndexedWidgetBuilder? itemBuilder;

  @override
  Widget build(BuildContext context) {
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
  }
}

class _SeparatorBuilder extends StatelessWidget {
  const _SeparatorBuilder({this.type});

  final AppListViewType? type;

  @override
  Widget build(BuildContext context) {
    return type == AppListViewType.separated ? Divider(color: context.color.grey5, thickness: Constant.borderHeight, height: 1) : const SizedBox.shrink();
  }
}

// void jumpToItem(int index) {
//   _listController.jumpToItem(
//     index: index,
//     scrollController: _scrollController,
//     alignment: 0.5,
//   );
// }

// void animateToItem(int index) {
//   _listController.animateToItem(
//     index: index,
//     scrollController: _scrollController,
//     alignment: 0.5,
//     // You can provide duration and curve depending on the estimated
//     // distance between currentPosition and the target item position.
//     duration: (estimatedDistance) => Duration(milliseconds: 250),
//     curve: (estimatedDistance) => Curves.easeInOut,
//   );
// }
