import 'package:flutter/material.dart';

import '../../shared/index.dart';
import '../index.dart';

enum ButtonType { fill, outline, link }

class AppButton extends StatelessWidget {
  const AppButton(
    this.value, {
    super.key,
    this.type = ButtonType.fill,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.height,
    this.width,
    this.isBold = true,
    this.isExpand = true,
    this.leftIcon,
    this.paddingButtonLink,
    this.isUnderline,
  });
  final ButtonType type;
  final String? value;
  final Function()? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final bool isBold;
  final bool isExpand;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? leftIcon;
  final EdgeInsetsGeometry? paddingButtonLink;
  final bool? isUnderline;

  @override
  Widget build(BuildContext context) {
    var locked = false;

    void onTap() {
      if (locked) return;
      if (!locked) {
        locked = true;
        Future.delayed(const Duration(milliseconds: 1000), () => locked = false);
      }
      onPressed?.call();
    }

    Widget _buildContent() {
      switch (type) {
        case ButtonType.outline:
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              side: BorderSide(color: color ?? Theme.of(context).colorScheme.secondary, width: 1.0, style: BorderStyle.solid),
              minimumSize: isExpand ? Size.fromHeight(height ?? UiConstants.defaultSizeButton) : null,
              padding: const EdgeInsets.all(0),
            ),
            onPressed: onTap,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: SizedBox(width: 20, child: leftIcon),
                ),
                Padding(padding: const EdgeInsets.only(right: 5.0), child: AppText(value, isBold: isBold, color: color, type: TextType.content)),
              ],
            ),
          );

        case ButtonType.link:
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: paddingButtonLink ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              child: AppText(value, color: color ?? Theme.of(context).colorScheme.secondary, isBold: isBold, type: TextType.content, decoration: isUnderline == true ? TextDecoration.underline : TextDecoration.none),
            ),
          );

        default:
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              backgroundColor: onPressed == null ? Theme.of(context).colorScheme.outlineVariant : backgroundColor ?? Theme.of(context).colorScheme.secondary,
              minimumSize: isExpand ? Size.fromHeight(height ?? UiConstants.defaultSizeButton) : null,
            ),
            onPressed: onTap,
            child: Stack(
              children: <Widget>[
                leftIcon != null ? Align(alignment: Alignment.centerLeft, child: SizedBox(width: 20, child: leftIcon)) : const SizedBox.shrink(),
                Align(alignment: Alignment.center, child: AppText(value, isBold: isBold, color: color ?? Theme.of(context).colorScheme.onPrimary, type: TextType.title)),
              ],
            ),
          );
      }
    }

    return SizedBox(
      height: height ?? UiConstants.defaultSizeButton,
      child: _buildContent(),
    );
  }
}
