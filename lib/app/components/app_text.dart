import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../resources/index.dart';

enum TextType { header, title, content, text }

class AppText extends ConsumerWidget {
  const AppText(
    this.value, {
    super.key,
    this.lineHeight,
    this.type,
    this.maxLines,
    this.fontStyle,
    this.textStyle,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.color,
    this.isBold,
    this.decoration,
  });
  final String? value;
  final TextType? type;
  final TextStyle? textStyle;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final Color? color;
  final bool? isBold;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? lineHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle? _textStyle;
    bool _isBold = false;
    Color? _color = color;
    final t = type ?? TextType.content; // default content

    switch (t) {
      case TextType.header:
        _textStyle = context.titleLarge; // AppTextStyles.h20;
        _isBold = isBold ?? true;
        break;
      case TextType.title:
        _textStyle = context.titleMedium; // AppTextStyles.h16;
        _isBold = isBold ?? true;
        break;
      case TextType.content:
        _textStyle = context.bodyMedium; // AppTextStyles.h14;
        _isBold = isBold ?? false;
        _color = color ?? context.textTheme.bodyMedium?.color;
        break;
      case TextType.text:
        _textStyle = context.labelMedium;
        _isBold = isBold ?? false;
        break;
      default:
        break;
    }
    final _fontWeight = _isBold == true ? FontWeight.w700 : FontWeight.w400;
    return Text(
      value ?? '',
      style: textStyle ??
          _textStyle?.copyWith(
            color: _color,
            decoration: decoration,
            fontStyle: fontStyle,
            height: lineHeight,
            fontWeight: _fontWeight,
          ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      softWrap: softWrap,
      maxLines: maxLines ?? 1,
    );
  }
}
