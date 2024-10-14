import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('SettingPage > build');
    final isDarkMode = ref.watch(isDarkModeProvider);

    Future<void> onPressLogout(_) async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Are you sure you want to log out?',
        onConfirm: () async {
          await ref.read(authProvider.notifier).logout();
          await ref.nav.replace(const LoginRoute());
        },
      ));
      Log.d('on close popup..: $result');
    }

    Future<void> onPressDeleteAccount(_) async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Your data will be deleted and cannot be recovered.\nAre you sure you want to delete account?',
        onConfirm: () async {
          // await ref.read(authProvider.notifier).logout();
          await ref.nav.replace(const LoginRoute());
        },
      ));
      Log.d('on close popup..: $result');
    }

    void onChanged(bool? val) {
      ref.update(themeModeProvider, (_) => val == true ? 2 : 1); //TODO: fix me
    }

    void onPressed(BuildContext context) {
      Log.d('tap cell');
    }

    return AppScaffold(
      appBar: AppTopBar(text: 'Setting'),
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: [
          SettingsSection(
            title: const AppText('Account'),
            tiles: [
              SettingsTile.navigation(leading: const Icon(Icons.manage_accounts), title: const AppText('Account Management', type: TextType.title, isBold: false), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
              SettingsTile.navigation(leading: const Icon(Icons.security), title: const AppText('Security', type: TextType.title, isBold: false), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
            ],
          ),
          SettingsSection(
            title: const AppText('Settings'),
            tiles: [
              SettingsTile.navigation(leading: const Icon(Icons.language), title: const AppText('Language', type: TextType.title, isBold: false), value: const AppText('English', type: TextType.text), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
              SettingsTile.switchTile(leading: Icon(isDarkMode == true ? Icons.brightness_4_outlined : Icons.dark_mode_outlined), title: const AppText('Eye Protection Mode', type: TextType.title, isBold: false), initialValue: isDarkMode, onToggle: onChanged),
              SettingsTile.navigation(leading: const Icon(Icons.delete), title: const AppText('Delete Account', type: TextType.title, isBold: false), onPressed: onPressDeleteAccount),
            ],
          ),
          SettingsSection(
            tiles: [SettingsTile.navigation(leading: const Icon(Icons.logout), title: const AppText('Logout', type: TextType.title, isBold: false), onPressed: onPressLogout)],
          ),
        ],
      ),
    );
  }
}
