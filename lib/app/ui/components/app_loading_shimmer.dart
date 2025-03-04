import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

enum LoadingShimmerType { search, newData, other }

class AppLoadingShimmer extends StatelessWidget {
  const AppLoadingShimmer({super.key, this.useSliverList = false, this.width, this.height, this.scrollDirection, this.type, this.padding});
  final bool? useSliverList;
  final double? width;
  final double? height;
  final Axis? scrollDirection;
  final LoadingShimmerType? type;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final content = type == LoadingShimmerType.search || type == LoadingShimmerType.newData
        ? AppShimmer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: scrollDirection ?? Axis.vertical,
                padding: padding ?? EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Constant.shimmerItemCount,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RectangleShimmer(
                    width: width ?? double.infinity,
                    height: height ?? 50,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
          )
        : type == LoadingShimmerType.other
            ? AppShimmer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        Constant.shimmerItemCount,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: RectangleShimmer(
                            width: width ?? double.infinity,
                            height: height ?? 50,
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : AppShimmer(
                child: ListView.builder(
                  padding: padding ?? EdgeInsets.zero,
                  scrollDirection: scrollDirection ?? Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Constant.shimmerItemCount,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: RectangleShimmer(
                      width: width ?? 150,
                      height: height ?? 200,
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
              );
    if (useSliverList == true) {
      return SliverToBoxAdapter(child: content);
    }
    return content;
  }
}
