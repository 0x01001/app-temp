import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../resources/index.dart';

class AppRefresher extends StatefulWidget {
  const AppRefresher({
    required this.refreshController,
    required this.child,
    super.key,
    this.enablePullUp = true,
    this.onRefresh,
    this.onLoadMore,
    this.noData = false,
    this.physics,
    this.emptyDataText,
    this.noMoreDataText,
  });

  final RefreshController refreshController;
  final bool enablePullUp;
  final Function()? onRefresh;
  final Function()? onLoadMore;
  final bool noData;
  final String? emptyDataText;
  final String? noMoreDataText;
  final Widget child;
  final ScrollPhysics? physics;

  @override
  State<AppRefresher> createState() => _AppRefresherState();
}

class _AppRefresherState extends State<AppRefresher> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.refreshController,
      enablePullUp: widget.enablePullUp,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoadMore,
      physics: widget.physics,
      enablePullDown: widget.onRefresh != null,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const SizedBox.shrink();
          } else if (mode == LoadStatus.loading) {
            body = const SizedBox(
              height: 60.0,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onLoadMore,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children: [
                      Text('Có lỗi xảy ra', style: context.bodyMedium, textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      const Icon(Icons.refresh_outlined),
                      const SizedBox(height: 8),
                      Text('Thử lại', style: context.bodyMedium),
                    ],
                  ),
                ),
              ),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = SizedBox(
              height: 50,
              child: Center(
                child: Text('Kéo lên để tải thêm', style: context.bodyMedium),
              ),
            );
          } else if (mode == LoadStatus.noMore) {
            body = SizedBox(
              height: widget.noData ? 50 : 0,
              child: Center(
                child: Text(
                  widget.noData ? (widget.noMoreDataText ?? 'Không có dữ liệu') : '',
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            body = const SizedBox.shrink();
          }
          return body;
        },
      ),
      child: widget.child,
    );
  }
}
