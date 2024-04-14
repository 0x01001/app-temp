import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../index.dart';

class AppSlider extends HookConsumerWidget {
  const AppSlider({
    required this.field,
    this.onChanged,
    this.validator,
    this.hintText,
    this.labelText,
    super.key,
  });

  final FieldType field;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('build: $field');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null ? AppText(labelText, type: TextType.content) : const SizedBox.shrink(),
        const SizedBox(height: 5),
        FormBuilderSlider(
          name: 'slider',
          // validator: checkValidatorBool(field),
          // onChanged: _onChanged,
          min: 0.0,
          max: 10.0,
          initialValue: 7.0,
          divisions: 20,
          activeColor: Colors.red,
          inactiveColor: Colors.pink[100],
          decoration: const InputDecoration(
            labelText: 'Number of things',
          ),
        ),
      ],
    );
  }
}
