import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class SignUpPage extends BasePage<AuthState, AutoDisposeStateNotifierProvider<AuthProvider, AppState<AuthState>>> {
  const SignUpPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<AuthProvider, AppState<AuthState>> get provider => authProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: AppTopBar(text: S.current.signUp),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: _Form(),
      ),
    );
  }
}

class _Form extends AppForm {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<String> getGender() {
    //   return [S.current.male, S.current.female, S.current.other];
    // }
    final errorText = useState('');

    Future<void> onSubmit() async {
      final data = getFormData();
      if (data != null) {
        final result = await ref.read(authProvider.notifier).register(data[FieldType.email.name], data[FieldType.password.name], data[FieldType.displayName.name]);
        if (result == true) {
          await getIt.get<AppNavigator>().push(const MainRoute());
        }
      }
    }

    Future<bool?> checkEmail(BaseInput data) async {
      final result = await super.onFocus(data);
      if (result == true) {
        formKey.currentState!.save();
        final data = formKey.currentState!.value[FieldType.email.name];
        if (data != null) {
          final check = await ref.read(authProvider.notifier).checkEmail(data.toString().trim());
          if (check == true) {
            errorText.value = S.current.emailAlreadyExists;
          }
        }
      }
      return null;
    }

    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          AppInput(field: FieldType.email, labelText: S.current.email, keyboardType: TextInputType.emailAddress, enableLoading: true, onFocus: checkEmail, errorText: errorText.value),
          const SizedBox(height: 15),
          AppInput(field: FieldType.signUpPassword, labelText: S.current.password, keyboardType: TextInputType.visiblePassword, onFocus: onFocus),
          const SizedBox(height: 15),
          AppInput(field: FieldType.confirmPassword, labelText: S.current.confirmPassword, keyboardType: TextInputType.visiblePassword, enableNextFocus: false, onFocus: onFocus, validator: (val) => validateRePassword(FieldType.signUpPassword.name, val)),
          const SizedBox(height: 15),
          AppInput(field: FieldType.displayName, labelText: S.current.displayName),
          const SizedBox(height: 15),
          // AppInput(field: FieldType.lastName, labelText: S.current.lastName),
          // SizedBox(height: 15),
          // AppDropdown(field: FieldType.gender, labelText: S.current.gender, hintText: '-- Choose --', items: getGender()),
          // SizedBox(height: 15),
          // AppInput(field: FieldType.phoneNumber, labelText: S.current.phone),
          // SizedBox(height: 15),
          // AppInput(field: FieldType.dateOfBirth, labelText: S.current.dateOfBirth, hintText: 'YYYY-MM-DD', enableNextFocus: false),
          // SizedBox(height: 15),
          AppButton(S.current.signUp, onPressed: onSubmit),
        ],
      ),
    );
  }
}
