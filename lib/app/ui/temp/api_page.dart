import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../index.dart';

@RoutePage()
class APIPage extends HookConsumerWidget {
  const APIPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // ref.read(tempProvider.notifier).loadData();
      return null;
    }, []);

    return AppScaffold(
      appBar: AppTopBar(text: 'API Test'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: AppButton(
          'Test',
          onPressed: () {
            // ref.read(tempProvider.notifier).loadDataSafe();
          },
        ),
      ),
    );
  }
}
