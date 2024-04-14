import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import 'show_color_scheme_colors.dart';

@RoutePage()
class UIPage extends StatelessWidget {
  const UIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppTopBar(text: 'UI Test'),
      body: const SingleChildScrollView(child: ShowColorSchemeColors()),
    );
  }
}
