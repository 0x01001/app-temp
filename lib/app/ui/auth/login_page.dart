import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class LoginPage extends BasePage<AuthState, AutoDisposeStateNotifierProvider<AuthProvider, AppState<AuthState>>> {
  const LoginPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<AuthProvider, AppState<AuthState>> get provider => authProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
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
          ref.nav.replace(const MainRoute());
        } else {
          formKey.currentState?.fields[FieldType.password.name]?.didChange('');
        }
      }
    }

    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 50.0), child: Assets.images.logo.svg())),
          AppInput(field: FieldType.email, nextField: FieldType.password, labelText: L.current.email, keyboardType: TextInputType.emailAddress, onFocus: onFocus),
          const SizedBox(height: 15),
          AppInput(field: FieldType.password, labelText: L.current.password, keyboardType: TextInputType.visiblePassword, enableNextFocus: false, onFocus: onFocus),
          const SizedBox(height: 30),
          AppButton(L.current.login, onPressed: onSubmit),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText('Don\'t have an account? '),
              GestureDetector(
                onTap: () => ref.nav.push(const SignUpRoute()),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: AppText(L.current.signUp, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
