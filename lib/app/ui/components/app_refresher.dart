import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../resources/index.dart';

class AppRefresher extends ConsumerWidget {
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
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: enablePullUp,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      physics: physics,
      enablePullDown: onRefresh != null,
      footer: CustomFooter(
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
                    Text(S.current.unknownException, style: context.bodyMedium, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Icon(Icons.refresh_outlined),
                    const SizedBox(height: 8),
                    Text(S.current.tryAgain, style: context.bodyMedium),
                  ],
                ),
              ),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = SizedBox(
              height: 50,
              child: Center(child: Text(S.current.pullToLoadMore, style: context.bodyMedium)),
            );
          } else if (mode == LoadStatus.noMore) {
            body = SizedBox(
              height: isShowNoData ? 50 : 0,
              child: Center(
                child: Text(
                  isShowNoData ? (noMoreDataText ?? S.current.noData) : '',
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
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
