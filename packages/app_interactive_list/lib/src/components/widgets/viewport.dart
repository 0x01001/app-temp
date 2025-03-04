import 'package:flutter/rendering.dart' hide RenderViewport;
import 'package:flutter/widgets.dart';

import '../rendering/viewport.dart';

part 'package:app_interactive_list/src/flutter/widgets/viewport.dart';

class AppScrollViewViewport extends Viewport {
  AppScrollViewViewport({
    required super.offset,
    super.key,
    super.axisDirection,
    super.crossAxisDirection,
    super.anchor,
    super.center,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior,
    super.slivers,
  });

  @override
  RenderViewport createRenderObject(BuildContext context) {
    final renderViewport = super.createRenderObject(context);
    return RenderAppScrollViewViewport(
      axisDirection: renderViewport.axisDirection,
      crossAxisDirection: renderViewport.crossAxisDirection,
      anchor: renderViewport.anchor,
      offset: renderViewport.offset,
      cacheExtent: renderViewport.cacheExtent,
      cacheExtentStyle: renderViewport.cacheExtentStyle,
      clipBehavior: renderViewport.clipBehavior,
    );
  }
}
