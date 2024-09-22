import 'package:flutter/material.dart';

import '../../../../shared/index.dart';
import '../../../index.dart';

/// Because [PagedListView] does not expose the [itemCount] property, itemCount = 0 on the first load and thus the Shimmer loading effect can not work. We need to create a fake ListView for the first load.
class ListViewLoader extends StatelessWidget {
  const ListViewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: Constant.shimmerItemCount,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ShimmerLoading(
          loadingWidget: _LoadingItem(),
          isLoading: true,
          child: _LoadingItem(),
        ),
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return const RectangleShimmer(width: 150, height: 220);
  }
}
