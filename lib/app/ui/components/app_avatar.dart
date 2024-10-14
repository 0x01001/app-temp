import 'package:flutter/material.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.text,
    this.textStyle,
    this.isActive = false,
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    this.onTap,
  });

  final String? text;
  final double? width;
  final double? height;
  final bool isActive;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? 60;
    final height = this.height ?? 60;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / 2),
        border: Border.all(color: context.theme.extension<CustomTheme>()?.borderButton ?? Colors.transparent, width: 0.5),
      ),
      child: Material(
        color: backgroundColor ?? context.colors.surface,
        borderRadius: BorderRadius.circular(width / 2),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Center(child: AppText(text?.trim().firstOrNull?.toUpperCase() ?? '', type: TextType.title, textStyle: textStyle)),
              Visibility(
                visible: isActive,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.white), color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
