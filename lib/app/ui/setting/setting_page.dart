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
    bool? isDarkMode = ref.watch(isDarkModeProvider);
    isDarkMode ??= MediaQuery.platformBrightnessOf(context) == Brightness.dark;

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

    void onChanged(bool? val) {
      ref.update<bool?>(isDarkModeProvider, (_) => val);
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
            title: const Text('Account'),
            tiles: [
              SettingsTile.navigation(leading: const Icon(Icons.manage_accounts), title: const Text('Account Management'), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
              SettingsTile.navigation(leading: const Icon(Icons.security), title: const Text('Security'), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
            ],
          ),
          SettingsSection(
            title: const Text('Settings'),
            tiles: [
              SettingsTile.navigation(leading: const Icon(Icons.language), title: const Text('Language'), value: const Text('English'), trailing: const Icon(Icons.navigate_next), onPressed: onPressed),
              SettingsTile.switchTile(leading: const Icon(Icons.dark_mode), title: const Text('Eye Protection Mode'), initialValue: isDarkMode, onToggle: onChanged),
            ],
          ),
          SettingsSection(
            tiles: [SettingsTile.navigation(leading: const Icon(Icons.logout), title: const Text('Logout'), onPressed: onPressLogout)],
          ),
        ],
      ),
    );
  }
}
