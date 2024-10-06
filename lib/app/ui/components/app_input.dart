import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class AppInput extends BaseInput {
  const AppInput({
    super.field,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
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
    this.enableBackgroundColor = true,
    this.enableBorder = true,
    this.borderRadius,
    this.backgroundColor,
    this.focusNode,
    super.key,
  });

  final FieldType? nextField;
  final bool enableLoading;
  final bool enableNextFocus;
  final bool enableBackgroundColor;
  final bool enableBorder;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxLines;
  final double? borderRadius;
  final String? errorText;
  final String? value;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final Future<void> Function(BaseInput)? onFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useTextEditingController(text: value);
    final _isShowText = useState(field == FieldType.password);
    final _isShowLoading = useState(false);
    final _isShowIcon = useState(false);
    final _focusNode = useFocusNode();
    final _border = enableBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Constant.defaultBorderRadiusTextInput)),
            borderSide: BorderSide(width: 0, color: context.theme.extension<CustomTheme>()?.borderButton ?? Colors.transparent),
          )
        : InputBorder.none;
    // debugPrint('build: $field');

    Future<void> callback() async {
      // debugPrint('onFocus: $field - ${_focusNode.hasFocus} - ${_controller.text}');
      if (_focusNode.hasFocus == false) {
        //   final val = _controller.text.toHalfWidth();  // convert fullsize to halfsize
        //   _controller.text = val;
        if (enableLoading) _isShowLoading.value = true;
        await onFocus?.call(this);
        if (enableLoading) _isShowLoading.value = false;
      }
    }

    useEffect(() {
      // debugPrint('focusNodes: ${field} - ${_focusNode.hasFocus}');
      _focusNode.addListener(callback);
      return () => _focusNode.removeListener(callback);
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
        name: field?.name ?? '',
        focusNode: focusNode ?? _focusNode,
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
          filled: enableBackgroundColor,
          fillColor: backgroundColor,
          contentPadding: EdgeInsets.fromLTRB(8, 16, suffixIcon != null || _buildSuffixIcon() != null ? 0 : 8, 16),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border.copyWith(borderSide: BorderSide(color: context.colors.primary)),
          disabledBorder: _border,
          labelText: hintText ?? labelText,
          labelStyle: context.bodySmall?.copyWith(color: context.theme.extension<CustomTheme>()?.disabled),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          alignLabelWithHint: true,
          isCollapsed: true,
          isDense: true,
          suffixIcon: suffixIcon ?? _buildSuffixIcon(),
          suffixIconConstraints: const BoxConstraints.expand(width: Constant.defaultSizeTextInput, height: Constant.defaultSizeTextInput),
          errorStyle: context.labelMedium?.copyWith(color: Colors.red),
          errorMaxLines: 3,
          errorText: errorText != null && errorText != '' ? errorText : null,
          errorBorder: _border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: _border.copyWith(borderSide: const BorderSide(color: Colors.red)),
          prefixIconConstraints: BoxConstraints.expand(width: prefixIcon != null ? 48 : 12, height: prefixIcon != null ? 48 : 12),
          prefixIcon: Align(widthFactor: 1.0, heightFactor: 1.0, child: prefixIcon),
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        autovalidateMode: AutovalidateMode.disabled,
        obscureText: _isShowText.value,
        maxLines: maxLines ?? 1,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) AppText(labelText, type: TextType.content),
        if (labelText != null) const SizedBox(height: 5),
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
