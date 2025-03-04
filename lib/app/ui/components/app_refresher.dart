import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/index.dart';
import '../../index.dart';

// enum AppRefresherType { normal, smart }

class AppRefresher extends HookConsumerWidget {
  const AppRefresher({
    required this.refreshController,
    required this.child,
    super.key,
    this.enablePullUp = true,
    this.onRefresh,
    this.onLoadMore,
    this.isShowNoData = false,
    this.physics,
    this.noMoreDataText,
    // this.scrollController,
    // this.type = AppRefresherType.smart,
  });

  final RefreshController refreshController;
  final bool enablePullUp;
  final Function()? onRefresh;
  final Function()? onLoadMore;
  final bool isShowNoData;
  final String? noMoreDataText;
  final Widget child;
  final ScrollPhysics? physics;
  // final ScrollController? scrollController;
  // final AppRefresherType? type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isNoMoreData = useState(false);

    return SmartRefresher(
      controller: refreshController,
      // scrollController: scrollController,
      enablePullUp: enablePullUp,
      enablePullDown: onRefresh != null,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      physics: physics,
      footer: CustomFooter(
        height: _isNoMoreData.value && !isShowNoData ? 0.0 : 60.0,
        onModeChange: (mode) => _isNoMoreData.value = mode == LoadStatus.noMore || mode == LoadStatus.idle,
        builder: (BuildContext context, LoadStatus? mode) {
          Log.d('AppRefresher > builder > mode: $mode');
          Widget body = const SizedBox.shrink();
          if (mode == LoadStatus.loading) {
            body = const SizedBox(
              height: 60.0,
              child: AppLoading(), // Center(child: CupertinoActivityIndicator()),
            );
          } else if (mode == LoadStatus.failed) {
            body = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onLoadMore,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    AppText(S.current.unknownException, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Icon(Icons.refresh_outlined),
                    const SizedBox(height: 8),
                    AppText(S.current.tryAgain),
                  ],
                ),
              ),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = SizedBox(
              height: 50,
              child: Center(child: AppText(S.current.pullToLoadMore)),
            );
          } else if (mode == LoadStatus.noMore) {
            body = !isShowNoData
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 50,
                    child: Center(
                      child: AppText(noMoreDataText ?? S.current.noData, textAlign: TextAlign.center),
                    ),
                  );
          }
          return body;
        },
      ),
      child: child,
    );
  }
}

// class AppReload extends HookConsumerWidget {
//   const AppReload({required this.child, this.methodKey, this.onReload, this.edgeOffset = 0.0, this.notificationPredicate = defaultScrollNotificationPredicate, super.key});
//   final Widget child;
//   final String? methodKey; // required if using with AppLoadMore
//   final Future<void> Function()? onReload;
//   final double edgeOffset;
//   final ScrollNotificationPredicate notificationPredicate;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //Log.d('AppReload > build');

//     Future<void> _onRefresh() async {
//       if (methodKey?.isNotEmpty == true) AppUtils.call(methodKey!);
//       onReload?.call();
//     }

//     return AppRefreshIndicator(notificationPredicate: notificationPredicate, edgeOffset: edgeOffset, onRefresh: _onRefresh, child: child);
//   }
// }

class AppLoadMore extends HookConsumerWidget {
  const AppLoadMore({required this.controller, required this.methodKey, this.onLoadMore, this.useSliverList, this.isLoading, super.key});
  final ScrollController controller;
  final String methodKey;
  final Future<bool?> Function(int? page)? onLoadMore;
  final bool? useSliverList;
  final bool? isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Log.d('AppLoadMore > build');
    final _canLoadMore = useState(true);
    final _isLoading = useState(false);
    final _page = useRef(Constant.initialPage);

    useEffect(() {
      AppUtils.register(methodKey, () {
        _page.value = Constant.initialPage;
        _canLoadMore.value = true;
      });

      return () => AppUtils.unregister(methodKey);
    }, []);

    Future<void> _onScroll() async {
      // Log.d('_onScroll: ${controller.position.extentAfter} - ${_canLoadMore.value}');
      if (!controller.hasClients || _isLoading.value || !_canLoadMore.value) return;
      final thresholdReached = controller.position.extentAfter < Constant.endReachedThreshold;
      // Log.d('AppLoadMore > _onScroll: $thresholdReached');
      if (thresholdReached) {
        try {
          _page.value++;
          _isLoading.value = true;
          _canLoadMore.value = await onLoadMore?.call(_page.value) ?? false;
          _isLoading.value = false;
        } catch (e) {
          Log.d('AppLoadMore > error: $e');
          _page.value--;
          _isLoading.value = false;
          _canLoadMore.value = true;
        }
      }
    }

    useEffect(() {
      controller.addListener(_onScroll);
      return () => controller.removeListener(_onScroll);
    }, [controller]);

    final content = _canLoadMore.value && _isLoading.value
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: Constant.defaultPadding),
            child: AppLoading(),
          )
        : const SizedBox.shrink();
    return useSliverList == true ? SliverToBoxAdapter(child: content) : content;
  }
}
