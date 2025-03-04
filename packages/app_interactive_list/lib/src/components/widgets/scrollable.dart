import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

part 'package:app_interactive_list/src/flutter/widgets/scrollable.dart';
part 'package:app_interactive_list/src/flutter/widgets/scrollable_helpers.dart';

class AppScrollable extends Scrollable {
  const AppScrollable({
    required super.viewportBuilder,
    super.key,
    super.axisDirection,
    super.controller,
    super.physics,
    super.incrementCalculator,
    super.excludeFromSemantics,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.restorationId,
    super.scrollBehavior,
    super.clipBehavior,
    this.ignorePointer = false,
  });

  factory AppScrollable.from({
    required Scrollable scrollable,
    bool ignorePointer = false,
  }) {
    return AppScrollable(
      key: scrollable.key,
      axisDirection: scrollable.axisDirection,
      controller: scrollable.controller,
      physics: scrollable.physics,
      viewportBuilder: scrollable.viewportBuilder,
      incrementCalculator: scrollable.incrementCalculator,
      excludeFromSemantics: scrollable.excludeFromSemantics,
      semanticChildCount: scrollable.semanticChildCount,
      dragStartBehavior: scrollable.dragStartBehavior,
      restorationId: scrollable.restorationId,
      scrollBehavior: scrollable.scrollBehavior,
      clipBehavior: scrollable.clipBehavior,
      ignorePointer: ignorePointer,
    );
  }

  final bool ignorePointer;

  @override
  AppScrollableState createState() => AppScrollableState();
}

class AppScrollableState extends ScrollableState {
  @override
  AppScrollable get widget {
    return super.widget as AppScrollable;
  }

  @override
  Map<Type, GestureRecognizerFactory> get _gestureRecognizers {
    if (widget.ignorePointer) {
      return const <Type, GestureRecognizerFactory>{};
    }
    return super._gestureRecognizers;
  }

  @override
  void _receivedPointerSignal(PointerSignalEvent event) {
    if (widget.ignorePointer) {
      return;
    }
    super._receivedPointerSignal(event);
  }
}
