import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../resources/index.dart';
import '../index.dart';

class AppInput extends BaseInput {
  const AppInput({
    required super.field,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.onSubmitted,
    this.maxLines,
    this.errorText,
    this.value,
    this.labelText,
    this.onFocus,
    this.nextField,
    this.enableLoading = false,
    this.enableNextFocus = true,
    super.key,
  });

  final FieldType? nextField;
  final bool enableLoading;
  final bool enableNextFocus;
  final String? Function(String?)? validator;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final String? errorText;
  final String? value;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final Future<void> Function(BaseInput)? onFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useTextEditingController(text: value);
    final _isShowText = useState(field == FieldType.password);
    final _isShowLoading = useState(false);
    final _isShowIcon = useState(false);
    final _focusNode = useFocusNode();
    debugPrint('build: $field');

    Future<void> callback() async {
      debugPrint('onFocus: $field - ${_focusNode.hasFocus} - ${_controller.text}');
      if (_focusNode.hasFocus == false) {
        //   final val = _controller.text.toHalfWidth();  // convert fullsize to halfsize
        //   _controller.text = val;

        if (enableLoading) _isShowLoading.value = true;
        await onFocus?.call(this);
        if (enableLoading) _isShowLoading.value = false;
      }
    }

    useEffect(() {
      debugPrint('focusNodes: ${field} - ${_focusNode.hasFocus}');
      _focusNode.addListener(callback);
      return;
    }, [_focusNode]);

    void onTextChanged(String? val) {
      _isShowIcon.value = val?.trim().isNotEmpty ?? false;
      onChanged?.call(val);
    }

    void showDate() {}

    void showText() {
      _isShowText.value = !_isShowText.value;
    }

    Widget? _buildSuffixIcon() {
      if (field == FieldType.dateOfBirth) {
        return _IconDate(onTap: showDate);
      } else if (enableLoading && _isShowLoading.value) {
        return const AppLoading(width: 20, height: 20, strokeWidth: 2);
      } else if ((field == FieldType.password || field == FieldType.confirmPassword || field == FieldType.signUpPassword) && _isShowIcon.value) {
        return _IconEye(isShowText: _isShowText.value, onTap: showText);
      }
      return null;
    }

    Widget _buildContent() {
      return FormBuilderTextField(
        // key: _fieldKey,
        name: field.name,
        focusNode: _focusNode,
        autocorrect: false,
        textAlignVertical: TextAlignVertical.center,
        style: context.bodySmall,
        controller: controller ?? _controller,
        validator: validator ?? checkValidator(field),
        onChanged: onTextChanged,
        textInputAction: enableNextFocus ? TextInputAction.next : TextInputAction.done,
        // onEditingComplete: enableNextFocus ? () => FocusScope.of(context).nextFocus() : null, // bug render
        onSubmitted: onSubmitted, // ?? (_) => FocusScope.of(context).unfocus(), // (val) => nextField != null ? onTextFieldSubmitted(field, nextField) : focusNodes.value[field]?.unfocus(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(8, 12, suffixIcon != null || _buildSuffixIcon() != null ? 0 : 8, 12),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0),
          ),
          labelText: hintText ?? labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          isCollapsed: true,
          isDense: true,
          suffixIcon: suffixIcon ?? _buildSuffixIcon(),
          suffixIconConstraints: const BoxConstraints.expand(width: 45, height: 45),
          errorStyle: context.labelMedium?.copyWith(color: Colors.red),
          errorMaxLines: 3,
          errorText: errorText != null && errorText != '' ? errorText : null,
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        autovalidateMode: AutovalidateMode.disabled,
        obscureText: _isShowText.value,
        maxLines: maxLines ?? 1,
        // onTapOutside: (_) => _focusNode.unfocus(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null ? AppText(labelText, type: TextType.content) : const SizedBox.shrink(),
        const SizedBox(height: 5),
        _buildContent(),
      ],
    );
  }
}

class _IconDate extends StatelessWidget {
  const _IconDate({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: const Icon(Icons.calendar_month), // Assets.svgs.calendar.svg(),
      ),
    );
  }
}

class _IconEye extends StatelessWidget {
  const _IconEye({required this.onTap, required this.isShowText});
  final VoidCallback onTap;
  final bool isShowText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: // isShowText ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
          Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Transform.translate(
            offset: const Offset(0, 0),
            child: isShowText ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
          ),
        ),
      ),
    );
  }
}
