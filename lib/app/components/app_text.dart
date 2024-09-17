import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
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
    this.linkColor,
    this.isBold,
    this.decoration,
    this.enableLinkify,
    this.onOpen,
  });
  final String? value;
  final TextType? type;
  final TextStyle? textStyle;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final Color? color;
  final Color? linkColor;
  final bool? isBold;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? lineHeight;
  final bool? enableLinkify;
  final void Function(LinkableElement)? onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle? _textStyle;
    bool _isBold = false;
    Color? _color = color;
    final t = type ?? TextType.content; // default content

    switch (t) {
      case TextType.header:
        _textStyle = context.titleLarge;
        _isBold = isBold ?? true;
        break;
      case TextType.title:
        _textStyle = context.titleMedium;
        _isBold = isBold ?? true;
        break;
      case TextType.content:
        _textStyle = context.bodyMedium;
        _isBold = isBold ?? false;
        _color = color ?? context.textTheme.bodyMedium?.color;
        break;
      case TextType.text:
        _textStyle = context.bodySmall;
        _isBold = isBold ?? false;
        break;
      default:
        break;
    }
    final _fontWeight = _isBold == true ? FontWeight.w700 : FontWeight.w400;
    return enableLinkify == true
        ? Linkify(
            onOpen: onOpen,
            text: value ?? '',
            style: textStyle ??
                _textStyle?.copyWith(
                  color: _color,
                  decoration: decoration,
                  fontStyle: fontStyle,
                  height: lineHeight,
                  fontWeight: _fontWeight,
                ),
            overflow: overflow ?? TextOverflow.ellipsis,
            linkStyle: context.labelMedium?.copyWith(color: linkColor ?? context.colors.primary, decoration: decoration ?? TextDecoration.underline),
          )
        : Text(
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
