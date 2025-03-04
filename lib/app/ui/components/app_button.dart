import 'package:flutter/material.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

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
    this.borderWidth,
    this.height,
    this.width,
    this.isBold = true,
    this.isExpand = true,
    this.leftIcon,
    this.paddingButtonLink,
    this.isUnderline,
    this.textType,
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
  final double? borderWidth;
  final Widget? leftIcon;
  final EdgeInsetsGeometry? paddingButtonLink;
  final bool? isUnderline;
  final TextType? textType;

  @override
  Widget build(BuildContext context) {
    var locked = false;

    void onTap() {
      if (locked) return;
      if (!locked) {
        locked = true;
        Future.delayed(const Duration(milliseconds: 1000), () => locked = false);
      }
      if (context.mounted) onPressed?.call();
    }

    Widget _buildContent() {
      switch (type) {
        case ButtonType.outline:
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? Constant.defaultBorderRadiusButton)),
              side: BorderSide(color: onPressed == null ? appColor.disabled : color ?? context.colors.primary, width: borderWidth ?? 1.0, style: BorderStyle.solid),
              minimumSize: isExpand ? Size.fromHeight(height ?? Constant.defaultSizeButton) : null,
              padding: const EdgeInsets.all(0),
            ),
            onPressed: onPressed != null ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftIcon != null ? leftIcon! : const SizedBox.shrink(),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0), child: AppText(value, isBold: isBold, color: onPressed == null ? appColor.grey5 : color, type: TextType.text)),
                ],
              ),
            ),
          );

        case ButtonType.link:
          return InkWell(
            onTap: onTap,
            child: Padding(
              padding: paddingButtonLink ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Align(alignment: Alignment.centerLeft, child: AppText(value, type: textType ?? TextType.content, color: color ?? context.colors.primary, isBold: isBold, decoration: isUnderline == true ? TextDecoration.underline : TextDecoration.none)),
            ),
          );

        default:
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? Constant.defaultBorderRadiusButton)),
              backgroundColor: onPressed == null ? appColor.disabled : backgroundColor ?? context.colors.primary,
              minimumSize: isExpand ? Size.fromHeight(height ?? Constant.defaultSizeButton) : null,
              padding: const EdgeInsets.all(0),
            ),
            onPressed: onPressed != null ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftIcon != null ? leftIcon! : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AppText(value, isBold: isBold, color: color ?? context.colors.inverseSurface, type: TextType.text),
                  ),
                ],
              ),
            ),
          );
      }
    }

    return SizedBox(
      height: height ?? Constant.defaultSizeButton,
      child: _buildContent(),
    );
  }
}
