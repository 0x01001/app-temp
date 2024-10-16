import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../index.dart';

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
  });

  final RefreshController refreshController;
  final bool enablePullUp;
  final Function()? onRefresh;
  final Function()? onLoadMore;
  final bool isShowNoData;
  final String? noMoreDataText;
  final Widget child;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isNoMoreData = useState(false);
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: enablePullUp,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      physics: physics,
      enablePullDown: onRefresh != null,
      footer: CustomFooter(
        height: _isNoMoreData.value && !isShowNoData ? 0.0 : 60.0,
        onModeChange: (mode) => _isNoMoreData.value = mode == LoadStatus.noMore,
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body = const SizedBox.shrink();
          if (mode == LoadStatus.loading) {
            body = const SizedBox(
              height: 60.0,
              child: Center(child: CupertinoActivityIndicator()),
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
                    AppText(L.current.unknownException, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Icon(Icons.refresh_outlined),
                    const SizedBox(height: 8),
                    AppText(L.current.tryAgain),
                  ],
                ),
              ),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = SizedBox(
              height: 50,
              child: Center(child: AppText(L.current.pullToLoadMore)),
            );
          } else if (mode == LoadStatus.noMore) {
            body = !isShowNoData
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 50,
                    child: Center(
                      child: AppText(noMoreDataText ?? L.current.noData, textAlign: TextAlign.center),
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
