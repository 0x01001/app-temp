import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';
import 'provider/provider.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      hideKeyboardWhenTouchOutside: true,
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
    Future<void> onSubmit() async {
      final data = getFormData();
      if (data != null) {
        final result = await ref.read(authProvider.notifier).login(data[FieldType.email.name], data[FieldType.password.name]);
        if (result == true) {
          getIt.get<AppNavigator>().replace(const MainRoute());
        } else {
          formKey.currentState?.fields[FieldType.password.name]?.didChange('');
        }
      }
    }

    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          AppInput(field: FieldType.email, nextField: FieldType.password, labelText: S.current.email, keyboardType: TextInputType.emailAddress, onFocus: onFocus),
          const SizedBox(height: 15),
          AppInput(field: FieldType.password, labelText: S.current.password, keyboardType: TextInputType.visiblePassword, enableNextFocus: false, onFocus: onFocus),
          const SizedBox(height: 20),
          AppButton(S.current.login, onPressed: onSubmit),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Don\'t have an account? ', style: context.bodyMedium),
                  TextSpan(
                    text: S.current.signUp,
                    style: context.bodyMedium?.copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () => getIt.get<AppNavigator>().push(const SignUpRoute()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
