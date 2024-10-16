import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/index.dart';
import '../index.dart';

abstract class BasePage<T extends BaseState, P extends ProviderListenable<AppState<T>>> extends HookConsumerWidget {
  const BasePage({super.key});

  P get provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    L.instance.init(context);
    AppSize.init(context);

    ref.listen(
      provider.select((value) => value.appException),
      (previous, next) async {
        if (previous != next && next != null) {
          await ref.exception.handleException(next);
        }
      },
    );

    return Stack(
      children: [
        render(context, ref),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) => Visibility(
            visible: ref.watch(provider.select((value) => value.isLoading ?? false)),
            child: const AppLoading(),
          ),
        ),
      ],
    );
  }

  Widget render(BuildContext context, WidgetRef ref);
}
