import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('HomePage > build');

    return AppScaffold(
      appBar: AppTopBar(text: 'Home'),
      body: RefreshIndicator(
        onRefresh: () {
          final completer = Completer<void>();
          return completer.future;
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppButton(
            'Test',
            onPressed: () {
              getIt.get<AppNavigator>().showSuccessMessager('message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123.');
            },
          ),
        ),
      ),
    );
  }
}
