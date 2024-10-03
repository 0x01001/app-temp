import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.text,
    this.textStyle,
    this.isActive = false,
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
  });

  final String text;
  final double? width;
  final double? height;
  final bool isActive;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? 60;
    final height = this.height ?? 60;

    return Container(
      height: height,
      width: width,
      color: backgroundColor ?? Colors.black,
      // border: SolidBorder.allRadius(radius: width / 2),
      child: Stack(
        children: [
          Center(
            child: AppText(
              text.trim().firstOrNull?.toUpperCase(),
              // style: textStyle ??
              //     ts(
              //       fontSize: 24.rps,
              //       fontWeight: FontWeight.w700,
              //       color: color.white,
              //     ),
            ),
          ),
          Visibility(
            visible: isActive,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 14,
                height: 14,
                color: Colors.green,
                // border: SolidBorder.allRadius(radius: 7.rps, borderColor: color.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
