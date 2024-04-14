import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ColorCard extends StatefulWidget {
  const ColorCard({
    required this.label,
    required this.color,
    required this.textColor,
    super.key,
    this.shadowColor,
    this.size,
    this.elevation,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Color? shadowColor;
  final Size? size;

  final double? elevation;

  @override
  State<ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<ColorCard> {
  late String materialName = '';
  late String nameThatColor = '';
  late String space;
  late String hexCode;

  @override
  void initState() {
    super.initState();
    space = materialName == '' ? '' : ' ';
    hexCode = widget.color.hexCode;
  }

  @override
  void didUpdateWidget(covariant ColorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color) {
      space = materialName == '' ? '' : ' ';
      hexCode = widget.color.hexCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 10;
    final Size effectiveSize = widget.size ?? const Size(90, 50);

    final String hexCode = widget.color.hexCode;

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: widget.color,
        ),
        width: effectiveSize.width,
        height: effectiveSize.height,
        child: Tooltip(
          waitDuration: const Duration(milliseconds: 700),
          message: 'Color #$hexCode $nameThatColor$space$materialName.'
              '\nTap to copy color to Clipboard.',
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              // unawaited(copyColorToClipboard(context, widget.color));
            },
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(color: widget.textColor, fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
