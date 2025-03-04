import 'dart:math' as math;

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show Matrix4, Quad, Vector3;

part 'package:app_interactive_list/src/flutter/widgets/interactive_viewer.dart';

class AppInteractiveViewer extends InteractiveViewer {
  AppInteractiveViewer({
    required super.child,
    super.key,
    super.panAxis,
    super.maxScale,
    super.transformationController,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  });

  AppInteractiveViewer.builder({
    required super.builder,
    super.key,
    super.panAxis,
    super.maxScale,
    super.transformationController,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
  }) : super.builder();

  final GestureScaleStartCallback? onScaleStart;

  final GestureScaleUpdateCallback? onScaleUpdate;

  final GestureScaleEndCallback? onScaleEnd;

  @override
  State<InteractiveViewer> createState() => _AppInteractiveViewerState();
}

class _AppInteractiveViewerState extends _InteractiveViewerState {
  @override
  AppInteractiveViewer get widget {
    return super.widget as AppInteractiveViewer;
  }

  @override
  void _onScaleStart(ScaleStartDetails details) {
    super._onScaleStart(details);
    widget.onScaleStart?.call(details);
  }

  @override
  void _onScaleUpdate(ScaleUpdateDetails details) {
    super._onScaleUpdate(details);
    widget.onScaleUpdate?.call(details);
  }

  @override
  void _onScaleEnd(ScaleEndDetails details) {
    super._onScaleEnd(details);
    widget.onScaleEnd?.call(details);
  }
}
