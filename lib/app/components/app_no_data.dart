import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'app_text.dart';

class AppNoData extends HookWidget {
  const AppNoData({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: AppText('No data'));
  }
}
