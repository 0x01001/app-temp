import 'package:flutter/material.dart';

const int _kDefaultMS = 1000;

enum AppShimmerAnimationType { shimmer, stretch }

class AppShimmer extends StatefulWidget {
  const AppShimmer({super.key, this.shape, this.padding, this.color, this.shimmerColor, this.width, this.height, this.margin, this.borderRadius, this.duration, this.active = true, this.type = AppShimmerAnimationType.shimmer, this.stretchWidth});

  final BoxShape? shape;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? shimmerColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Duration? duration;

  /// Show animation or not, default is true.
  final bool? active;

  /// The animation type of the skeleton, default is [AppShimmerAnimationType.shimmer].
  /// If you specify [AppShimmerAnimationType.stretch] type, you must set [width] and [stretchWidth].
  final AppShimmerAnimationType? type;

  /// The 'animate to' width when choose [AppShimmerAnimationType.stretch] type.
  final double? stretchWidth;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    final Duration duration = widget.duration ?? const Duration(milliseconds: _kDefaultMS);
    _controller = AnimationController(vsync: this, duration: duration);
    _setupAnimationAndStart();
  }

  @override
  void didUpdateWidget(AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setupAnimationAndStart();
  }

  void _setupAnimationAndStart() {
    _animation = _genTween().animate(CurvedAnimation(curve: Curves.linear, parent: _controller!));

    if (widget.type == AppShimmerAnimationType.shimmer) {
      _animation?.addStatusListener(_handleShimmerAnimationStatus);
    } else {
      _animation?.addStatusListener(_handleStretchAnimationStatus);
    }

    if (widget.active == true) _controller?.forward();
  }

  Tween<double> _genTween() {
    return (widget.type == AppShimmerAnimationType.shimmer) ? Tween<double>(begin: -1.0, end: 2.0) : Tween<double>(begin: widget.width, end: widget.stretchWidth);
  }

  void _handleShimmerAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      if (widget.active == true) _controller?.repeat();
    }
  }

  void _handleStretchAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (widget.active == true) _controller?.reverse();
    } else if (status == AnimationStatus.dismissed) {
      if (widget.active == true) _controller?.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          /// config style
          final BoxShape shape = widget.shape ?? BoxShape.rectangle;
          final Color color = widget.color ?? const Color(0xFFE8E8E8);
          final Color shimmerColor = widget.shimmerColor ?? const Color(0xFFEDEDED);
          final val = _animation?.value ?? 0;
          final gradient = widget.type == AppShimmerAnimationType.shimmer
              ? LinearGradient(
                  begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                  end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
                  colors: [color, shimmerColor.withAlpha(200), color],
                  stops: [val - 0.4, val, val + 0.4],
                )
              : null;
          final width = widget.type == AppShimmerAnimationType.shimmer ? widget.width : val;
          final decColor = widget.type == AppShimmerAnimationType.stretch ? color : null;

          return Container(
            decoration: BoxDecoration(shape: shape, borderRadius: widget.borderRadius, color: decColor, gradient: gradient),
            padding: widget.padding,
            width: width,
            height: widget.height,
            margin: widget.margin,
          );
        });
  }
}
