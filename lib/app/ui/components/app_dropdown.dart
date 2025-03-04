import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

enum DropdownType { form, bottom }

class DataDropdown {
  int? index;
  String? title;
  DataDropdown(this.index, this.title);
}

class AppDropdown extends HookConsumerWidget {
  const AppDropdown({
    required this.items,
    this.field,
    super.key,
    this.type = DropdownType.form,
    this.direction = Axis.vertical,
    // this.item,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.value,
    this.errorText,
  });
  final DropdownType type;
  final List<String> items;
  // final String? item;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final String? errorText;

  final FieldType? field;
  final String? value;
  final String? Function(String?)? validator;
  final Axis? direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _focusNode = useFocusNode();
    final valueListenable = ValueNotifier<String?>(value);
    final isSmall = (valueListenable.value?.length ?? 0) <= 3;

    Widget _buildContent() {
      switch (type) {
        case DropdownType.bottom:
          return DropdownButton2(
            isExpanded: true,
            hint: hintText?.isNotEmpty == true ? AppText(hintText, type: TextType.content) : null,
            items: items.map((x) => DropdownItem<String>(value: x, child: Padding(padding: const EdgeInsets.only(left: 16.0), child: AppText(x)))).toList(),
            valueListenable: valueListenable,
            onChanged: (val) {
              valueListenable.value = value;
              onChanged?.call(val ?? '');
            },
            buttonStyleData: ButtonStyleData(height: 24, width: isSmall ? 65 : 70, decoration: BoxDecoration(color: context.colors.surface)),
            menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14)),
            dropdownStyleData: DropdownStyleData(maxHeight: 400, width: isSmall ? 95 : 100, offset: const Offset(0, -3), padding: EdgeInsets.zero, decoration: BoxDecoration(color: context.colors.surface)),
            dropdownSeparator: DropdownSeparator(height: 1, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Divider(color: appColor.grey5, thickness: Constant.borderHeight, height: 1))),
          );

        default:
          return FormBuilderDropdown(
            name: field?.name ?? '',
            initialValue: value == '' ? null : value,
            items: items.map((x) => DropdownMenuItem(alignment: AlignmentDirectional.centerStart, value: x, child: AppText(x, type: TextType.content))).toList(),
            focusNode: _focusNode,
            style: context.bodySmall, // AppTextStyles.h14.copyWith(color: theme.appColors.black),
            validator: validator ?? checkValidator(field),
            icon: const SizedBox(width: 8),
            // hint: AppText(hintText, type: TextType.content),
            onChanged: (val) {
              // formKey?.currentState?.fields[name]?.didChange(null);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 0.0),
              ),
              hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isDense: true,
              suffixIcon: const Icon(Icons.arrow_drop_down, size: 30),
              suffixIconConstraints: const BoxConstraints.expand(width: 45, height: 45),
              errorStyle: context.labelSmall?.copyWith(color: Colors.red),
              errorMaxLines: 3,
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(width: 0.5, color: Colors.redAccent),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 0.5, color: Colors.redAccent),
              ),
              focusColor: Colors.redAccent,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(width: 0.0),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          );
      }
    }

    return direction == Axis.vertical
        ? Column(
            children: [
              Align(alignment: Alignment.centerLeft, child: AppText(labelText, type: TextType.content)),
              const SizedBox(height: 5),
              DropdownButtonHideUnderline(child: _buildContent()),
            ],
          )
        : DropdownButtonHideUnderline(child: _buildContent());
  }
}
