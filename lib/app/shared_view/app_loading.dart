import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.width, this.height, this.strokeWidth, this.isCenter = true});
  final double? width;
  final double? height;
  final double? strokeWidth;
  final bool? isCenter;

  @override
  Widget build(BuildContext context) {
    // final loading = SizedBox(
    //   width: width ?? 30,
    //   height: height ?? 30,
    //   child: CircularProgressIndicator(
    //     strokeWidth: strokeWidth ?? 3,
    //     valueColor: AlwaysStoppedAnimation<Color>(AppColors.current.primaryColor),
    //   ),
    // );
    final loading = Transform.scale(
      scale: 0.7,
      child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface),
    );

    return isCenter == true ? Center(child: loading) : loading;
  }
}
