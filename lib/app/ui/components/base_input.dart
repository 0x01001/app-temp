import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../index.dart';

class BaseInput extends HookConsumerWidget {
  const BaseInput({required this.field, super.key});

  final FieldType field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
