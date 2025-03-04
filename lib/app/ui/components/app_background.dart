import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: double.infinity,
      duration: kThemeChangeDuration,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: [
            Color.fromARGB(255, 30, 32, 60),
            Color.fromARGB(255, 50, 52, 80),
          ],
        ),
      ),
      child: child,
    );
  }
}
