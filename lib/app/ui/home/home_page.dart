import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class HomePage extends BasePage<HomeState, AutoDisposeStateNotifierProvider<HomeProvider, AppState<HomeState>>> {
  const HomePage({super.key});

  @override
  AutoDisposeStateNotifierProvider<HomeProvider, AppState<HomeState>> get provider => homeProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
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
          child: Column(
            children: [
              AppButton(
                'Test 7',
                onPressed: () {
                  getIt.get<AppNavigator>().showSuccessMessager('message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123 message 123.');
                },
              ),
              // TextButton(
              //   onPressed: () {
              //     // bug: https://github.com/flutter/flutter/issues/96216
              //     ScaffoldMessenger.of(context).showMaterialBanner(
              //       MaterialBanner(
              //         content: const Text('This is a MaterialBanner'),
              //         actions: <Widget>[
              //           TextButton(
              //             onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              //             child: const Text('DISMISS'),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   child: const Text('Test'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
