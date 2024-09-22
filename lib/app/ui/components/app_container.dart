// import 'package:flutter/material.dart';

// import '../index.dart';

// enum ShapeType {
//   rectangle,
//   circle,
// }

// class AppContainer extends StatelessWidget {
//   const AppContainer({
//     super.key,
//     this.child,
//     this.onTap,
//     this.margin,
//     this.padding,
//     this.border,
//     this.color,
//     this.splashColor,
//     this.width,
//     this.height,
//     this.alignment,
//     this.boxShadow,
//     this.gradient,
//     this.shape = ShapeType.rectangle,
//   });

//   final Widget? child;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry? margin;
//   final EdgeInsetsGeometry? padding;
//   final CommonBorder? border;
//   final Color? color;
//   final Color? splashColor;
//   final double? width;
//   final double? height;
//   final AlignmentGeometry? alignment;
//   final List<BoxShadow>? boxShadow;
//   final Gradient? gradient;
//   final ShapeType shape;

//   bool get hasDecoration => !boxShadow.isNullOrEmpty || gradient != null || color != null;

//   @override
//   Widget build(BuildContext context) {
//     if (onTap == null) {
//       return _buildContainer(containerColor: color);
//     }
//     final material = Material(
//       borderRadius: shape == ShapeType.circle ? null : border?.borderRadius,
//       color: color,
//       // ignore: prefer_common_widgets
//       child: InkWell(
//         borderRadius: shape == ShapeType.circle ? null : border?.borderRadius,
//         splashColor: splashColor,
//         onTap: onTap,
//         child: _buildContainer(containerColor: Colors.transparent),
//       ),
//     );

//     switch (shape) {
//       case ShapeType.rectangle:
//         return material;
//       case ShapeType.circle:
//         return SizedBox(
//           width: width,
//           height: height,
//           child: ClipOval(
//             child: material,
//           ),
//         );
//     }
//   }

//   Widget _buildContainer({
//     Color? containerColor,
//   }) {
//     // ignore: prefer_common_widgets
//     final container = Container(
//       alignment: alignment,
//       margin: margin,
//       padding: padding,
//       width: width,
//       height: height,
//       decoration: border is DashBorder
//           ? DashBorderDecoration(dashBorder: border as DashBorder, shape: shape)
//           : BoxDecoration(
//               borderRadius: shape == ShapeType.circle ? null : border?.borderRadius,
//               color: containerColor,
//               border: border?.boxBorder,
//               boxShadow: boxShadow,
//               gradient: gradient,
//             ),
//       child: child,
//     );

//     switch (shape) {
//       case ShapeType.rectangle:
//         return container;
//       case ShapeType.circle:
//         return SizedBox(
//           width: width,
//           height: height,
//           child: ClipOval(child: container),
//         );
//     }
//   }
// }
