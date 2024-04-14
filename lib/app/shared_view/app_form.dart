import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../resources/index.dart';
import '../index.dart';

enum FieldType {
  email,
  password,
  signUpPassword,
  currentPassword,
  newPassword,
  resetPassword,
  confirmPassword,
  displayName,
  firstName,
  lastName,
  phoneNumber,
  gender,
  dateOfBirth,
  postCode,
  address,
}

//https://codefool.tumblr.com/post/15288874550/list-of-valid-and-invalid-email-addresses
FormFieldValidator<String> validateEmail({String? errorText}) => (valueCandidate) {
      // final emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
      final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

      if (!emailRegex.hasMatch(valueCandidate!.trim())) {
        return errorText ?? FormBuilderLocalizations.current.emailErrorText;
      }
      return null;
      // return (valueCandidate?.isNotEmpty ?? false) && !EmailValidator.validate(valueCandidate!.trim()) ? errorText ?? FormBuilderLocalizations.current.emailErrorText : null;
    };
FormFieldValidator<String> validateDate({String? errorText}) => (valueCandidate) {
      if (valueCandidate != null) {
        final lang = S.current;
        // //https://regex101.com/r/3TZfyU/1
        final regex = RegExp(
            r'^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$');
        //debugPrint('valueCandidate: $valueCandidate');
        if (!regex.hasMatch(valueCandidate.trim())) {
          return errorText ?? lang.invalidFormat;
        }
        final date = DateFormat('yyyy-MM-dd').parse(valueCandidate.trim());
        final today = DateTime.now();
        if (date.isAfter(today)) {
          return errorText ?? lang.invalidFormat;
        }
      }
      return null;
    };

FormFieldValidator<String> checkWhitespace({String? errorText}) => (valueCandidate) {
      if (valueCandidate != null && (valueCandidate.startsWith(' ') || valueCandidate.endsWith(' '))) {
        return errorText ?? S.current.lengthPassword(6, 128);
      }
      return null;
    };

FormFieldValidator<String> validatePassword({String? errorText}) => (valueCandidate) {
      final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*[\d]{1,})(?=.*[\W]{1,}).*$');
      if (!regex.hasMatch(valueCandidate!.trim())) {
        return errorText ?? S.current.lengthPassword(6, 128);
      }
      return null;
    };

List<String? Function(T?)> checkLengthPassword<T>({String? errorText}) => [
      FormBuilderValidators.required(errorText: errorText ?? S.current.required),
      FormBuilderValidators.minLength(8, errorText: errorText ?? S.current.lengthPassword(6, 128)),
      FormBuilderValidators.maxLength(128, errorText: errorText ?? S.current.lengthPassword(6, 128)),
    ];

List<String? Function(T?)> checkLength<T>(int from, int to) => [
      FormBuilderValidators.required(errorText: S.current.required),
      FormBuilderValidators.minLength(from, errorText: S.current.lengthCharacter(from, to)),
      FormBuilderValidators.maxLength(to, errorText: S.current.lengthCharacter(from, to)),
    ];

String? Function(bool?) checkValidatorBool(FieldType type) {
  return FormBuilderValidators.equal(true, errorText: S.current.youMustAcceptTerms);
}

String? Function(String?) checkValidator(FieldType type) {
  switch (type) {
    case FieldType.address:
      return FormBuilderValidators.maxLength(128, errorText: S.current.lengthCharacter(0, 128));
    case FieldType.postCode:
      return FormBuilderValidators.maxLength(8, errorText: S.current.lengthCharacter(0, 8));

    case FieldType.gender:
      return FormBuilderValidators.required(errorText: S.current.required);
    case FieldType.dateOfBirth:
      return FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: S.current.required),
        //https://stackoverflow.com/questions/15491894/regex-to-validate-date-formats-dd-mm-yyyy-dd-mm-yyyy-dd-mm-yyyy-dd-mmm-yyyy
        // FormBuilderValidators.match(
        //     r'^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[13578]|1[02])\1(?:31))|(?:(\/|-|\.)(?:0?[13-9]|1[0-2])\2(?:29|30)))$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\3(?:29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:0?[1-9]|1\d|2[0-8])$',
        //     errorText:lang.invalidFormat),
        validateDate(errorText: S.current.invalidFormat),
      ]);
    case FieldType.phoneNumber:
      return FormBuilderValidators.compose([
        // FormBuilderValidators.match(r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/', errorText:lang.invalidFormat),
        FormBuilderValidators.integer(errorText: S.current.thisFieldMustBeNumber),
        FormBuilderValidators.maxLength(12, errorText: S.current.lengthCharacter(0, 12)),
      ]);
    case FieldType.confirmPassword:
      return FormBuilderValidators.required(errorText: S.current.required);
    case FieldType.newPassword:
    case FieldType.resetPassword:
    case FieldType.signUpPassword:
      return FormBuilderValidators.compose([
        ...checkLengthPassword(),
        validatePassword(),
        checkWhitespace(),
      ]);
    case FieldType.currentPassword:
      return FormBuilderValidators.compose([
        ...checkLengthPassword(errorText: S.current.wrongPassword),
        validatePassword(errorText: S.current.wrongPassword),
        checkWhitespace(errorText: S.current.wrongPassword),
      ]);
    case FieldType.password:
      return FormBuilderValidators.compose(checkLength(8, 128));
    case FieldType.email:
      return FormBuilderValidators.compose([
        ...checkLength(3, 256),
        // final RegExp emailRegex = RegExp(
        //   r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        // FormBuilderValidators.match(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$", errorText:lang.invalidFormat),
        validateEmail(errorText: S.current.invalid(S.current.email)),
      ]);

    default:
      return (String? _) => null;
  }
}

class AppForm extends HookConsumerWidget {
  AppForm({super.key});

  final formKey = useMemoized(() => GlobalKey<FormBuilderState>()); // don't move

  Future<bool?> onFocus(BaseInput data) async {
    return formKey.currentState?.fields[data.field.name]?.validate(focusOnInvalid: false) ?? false;
  }

  String? validateRePassword(key, value) {
    var result = checkValidator(FieldType.confirmPassword)(value);
    if (result == null) {
      formKey.currentState?.save();
      final data = formKey.currentState?.value;
      if (data != null && data[key] != data[FieldType.confirmPassword.name]) {
        result = S.current.passwordDoesNotMatch;
      }
    }
    return result;
  }

  Map<String, dynamic>? getFormData() {
    FocusManager.instance.primaryFocus?.unfocus();
    formKey.currentState?.save(); // don't move
    if (formKey.currentState?.validate() == true) {
      final result = Map<String, dynamic>.from(formKey.currentState!.value);
      for (final x in result.keys) {
        if (result[x] is String) result[x] = result[x].toString().trim();
      }
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
