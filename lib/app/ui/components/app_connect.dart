// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../resources/index.dart';
// import '../index.dart';

// class AppConnect extends HookConsumerWidget {
//   const AppConnect({this.child, super.key});

//   final Widget? child;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isConnected = ref.watch(connectProvider);
//     // Log.d('AppConnect > isConnected: ${isConnected.value}');

//     return Stack(
//       // fit: StackFit.expand,
//       children: [
//         child ?? const SizedBox.shrink(),
//         AnimatedSlide(
//           offset: Offset(0, isConnected.value == true || isConnected.value == null ? -1 : 0),
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//           child: Container(
//             height: 20.h,
//             width: double.infinity,
//             color: Colors.redAccent,
//             child: Center(child: AppText(L.current.noInternetException)),
//           ),
//         ),
//       ],
//     );
//   }
// }
