import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../index.dart';

class AppDatetime extends HookConsumerWidget {
  const AppDatetime({
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
        FormBuilderDateTimePicker(
          name: field.name,
          // focusNode: _focusNode,
          initialEntryMode: DatePickerEntryMode.calendar,
          initialValue: DateTime.now(),
          inputType: InputType.both,
          decoration: InputDecoration(
            labelText: 'Appointment Time',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // _formKey.currentState!.fields['date']?.didChange(null);
              },
            ),
          ),
          initialTime: const TimeOfDay(hour: 8, minute: 0),
          // locale: const Locale.fromSubtags(languageCode: 'fr'),
        ),
      ],
    );
  }
}
