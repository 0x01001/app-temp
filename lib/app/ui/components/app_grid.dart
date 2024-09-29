import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../shared/index.dart';
import '../../index.dart';

typedef GridFetcher<T> = Future<List<T>> Function({int? page, int? limit})?;
typedef GridWidgetBuilder<T> = Widget Function(BuildContext context, T item, int index);

class AppGrid<T> extends ConsumerStatefulWidget {
  const AppGrid({required this.itemBuilder, this.fetch, this.itemsPerPage, this.listData = const [], super.key});

  final GridWidgetBuilder<T> itemBuilder; // This will build widget.
  final GridFetcher<T>? fetch; // This will fetch data at a time.
  final int? itemsPerPage;
  final List<T> listData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AppGridState<T>();
}

class AppGridState<T> extends ConsumerState<AppGrid<T>> {
  final ScrollController _controller = ScrollController();
  int _nextPage = 1;
  bool _loading = true;
  bool _canLoadMore = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);

    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached = _controller.position.extentAfter < Constant.endReachedThreshold;

    if (thresholdReached) {
      _fetchData();
    }
  }

  Future<void> _refresh() async {
    _canLoadMore = true;
    widget.listData.clear();
    _nextPage = 1;
    await _fetchData();
  }

  Future<void> _fetchData({bool isLoadMore = false}) async {
    if (!isLoadMore) setState(() => _loading = true);

    final limit = widget.itemsPerPage ?? Constant.itemsPerPage;
    final result = await widget.fetch?.call(page: _nextPage, limit: limit);

    setState(() {
      widget.listData.addAll(result ?? []);
      _nextPage++;
      final count = result?.length ?? 0;
      if (count < limit) {
        _canLoadMore = false;
      }
      _loading = false;
    });
  }

  Future<void> reload() async {}

  void addItem(T item) {
    setState(() {
      widget.listData.add(item);
    });
  }

  void removeItem(T item) {}

  Widget _buildItem(BuildContext context, int index) {
    return widget.itemBuilder(context, widget.listData[index], index);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _controller,
      slivers: <Widget>[
        CupertinoSliverRefreshControl(onRefresh: _refresh),
        if (widget.listData.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 3,
                crossAxisSpacing: Constant.paddingItemsGrid,
                mainAxisSpacing: Constant.paddingItemsGrid,
                crossAxisCount: 3,
              ),
              delegate: SliverChildBuilderDelegate(_buildItem, childCount: widget.listData.length),
            ),
          ),
        if (_canLoadMore)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              child: const AppLoading(),
            ),
          ),
        if (widget.listData.isNullOrEmpty) const SliverFillRemaining(child: AppNoData()),
      ],
    );
  }
}
