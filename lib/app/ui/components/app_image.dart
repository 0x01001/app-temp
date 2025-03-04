import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class AppImageError extends ConsumerWidget {
  const AppImageError({super.key, this.width, this.height, this.fit});
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        // color: Colors.white,
        alignment: Alignment.center,
        child: const AspectRatio(
          aspectRatio: 1.0,
          child: Icon(Icons.error, color: Colors.white, size: 50),
          // child: Assets.images.error404.svg(
          //   // width: double.infinity,
          //   // height: double.infinity,
          //   fit: fit ?? BoxFit.fitWidth,
          //   // colorFilter: ColorFilter.mode(color ?? (_isDarkMode == true ? Colors.white : Colors.black), BlendMode.srcIn),
          // ),
        ),
      ),
    );
  }
}

class AppImage extends HookConsumerWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorBuilder;
  final Color? color;
  final int? maxCacheWidth;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  // final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  // final Widget Function(BuildContext, String)? placeholder;
  final Widget? Function(ExtendedImageState)? loadStateChanged;
  final Widget? loadingWidget;
  final bool useAnimation;
  final Object tag;
  final String? package;

  const AppImage(
    this.url, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.errorBuilder,
    this.fit,
    this.maxCacheWidth,
    this.borderRadius,
    this.border,
    // this.imageBuilder,
    // this.placeholder,
    this.loadStateChanged,
    this.loadingWidget,
    this.useAnimation = false,
    Object? tag,
    this.package,
  }) : tag = tag ?? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (url.isEmpty) {
      return AppImageError(width: width, height: height, fit: fit);
    }

    Widget? child = const SizedBox.shrink();
    final controller = useAnimationController(duration: 500.ms);
    final animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

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
          package: package,
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
            return errorBuilder ?? AppImageError(width: width, height: height, fit: fit);
          },
        );
      } else if (url.contains('http')) {
        child = ExtendedImage.network(
          url,
          cache: true,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          color: color,
          loadStateChanged: loadStateChanged ??
              (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return loadingWidget ?? const AppLoading();
                  case LoadState.completed:
                    controller.forward();
                    return FadeTransition(opacity: animation, child: state.completedWidget);
                  case LoadState.failed:
                    Log.e('AppImage > failed: $url');
                    return errorBuilder ?? AppImageError(width: width, height: height, fit: fit);
                }
              },
        );
        // CachedNetworkImage(
        //   maxWidthDiskCache: maxCacheWidth != null ? maxCacheWidth! : 368,
        //   imageUrl: url,
        //   width: width,
        //   height: height,
        //   memCacheHeight: height?.toInt(),
        //   memCacheWidth: width?.toInt(),
        //   fit: fit ?? BoxFit.cover,
        //   color: color,
        //   imageBuilder: imageBuilder,
        //   placeholder: placeholder,
        //   errorWidget: (_, __, ___) {
        //     Log.d('CachedNetworkImage > error: $___');
        //     return errorBuilder ?? _emptyWidget;
        //   },
        // );
      } else {
        child = Image.asset(
          url,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
          package: package,
          errorBuilder: (_, __, ___) {
            return errorBuilder ?? AppImageError(width: width, height: height, fit: fit);
          },
        );
      }
    }
    return _Container(
      width: width,
      height: height,
      borderRadius: borderRadius,
      border: border,
      child: useAnimation ? Hero(tag: tag, child: child) : child,
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({this.width, this.height, this.borderRadius, this.border, this.child});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(border: border, borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }
}
