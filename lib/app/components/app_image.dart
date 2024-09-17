import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppImage extends HookConsumerWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorBuilder;
  final Color? color;
  final int? maxCacheWidth;
  final BorderRadius? borderRadius;

  const AppImage(this.url, {super.key, this.color, this.width, this.height, this.errorBuilder, this.fit, this.maxCacheWidth, this.borderRadius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _isDarkMode = ref.watch(appProvider.select((x) => x.value?.isDarkMode));
    final _isDarkMode = AdaptiveTheme.of(context).mode.isDark;

    final _emptyWidget = SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset(
            'assets/images/image_error.svg',
            width: 80,
            height: 80,
            fit: fit ?? BoxFit.cover,
            colorFilter: ColorFilter.mode(color ?? (_isDarkMode == true ? Colors.white : Colors.black), BlendMode.srcIn),
          ),
        ),
      ),
    );

    if (url.isEmpty) {
      return _emptyWidget;
    }

    Widget? child = const SizedBox.shrink();
    if (url.contains('.svg')) {
      if (url.contains('http')) {
        child = SvgPicture.network(
          url,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      } else {
        child = SvgPicture.asset(
          url,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }
    } else {
      if (url.startsWith('file://')) {
        child = Image.file(
          File(url.replaceAll('file://', '')),
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorBuilder: (_, __, ___) {
            // Log.d('Image.file > error: $___');
            return errorBuilder ?? _emptyWidget;
          },
        );
      } else if (url.contains('http')) {
        child = CachedNetworkImage(
          maxWidthDiskCache: maxCacheWidth != null ? maxCacheWidth! : 368,
          imageUrl: url,
          width: width,
          height: height,
          memCacheHeight: height?.toInt(),
          memCacheWidth: width?.toInt(),
          fit: fit ?? BoxFit.cover,
          color: color,
          errorWidget: (_, __, ___) {
            return errorBuilder ?? _emptyWidget;
          },
        );
      } else {
        child = Image.asset(
          url,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
          errorBuilder: (_, __, ___) {
            return errorBuilder ?? _emptyWidget;
          },
        );
      }
    }
    return _Container(
      width: width,
      height: height,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({this.width, this.height, this.borderRadius, this.child});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }
}
