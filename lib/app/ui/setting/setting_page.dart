import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('SettingPage > build');
    final isDarkMode = ref.watch(isDarkModeProvider);
    final theme = ref.watch(themeModeProvider);
    final language = ref.watch(languageCodeProvider);

    Future<void> onPressLogout(_) async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Are you sure you want to log out?',
        onConfirm: () {
          ref.read(authProvider.notifier).logout();
        },
      ));
      Log.d('on close popup..: $result');
    }

    Future<void> onPressDeleteAccount(_) async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Your data will be deleted and cannot be recovered.\nAre you sure you want to delete account?',
        onConfirm: () {
          ref.read(authProvider.notifier).deleteAccount();
        },
      ));
      Log.d('on close popup..: $result');
    }

    void onPressed(BuildContext context) {
      Log.d('tap cell');
    }

    return AppScaffold(
      appBar: AppTopBar(text: L.current.setting),
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: [
          SettingsSection(
            title: const AppText('Account'),
            tiles: [
              SettingsTile.navigation(leading: const Icon(Icons.manage_accounts), title: const AppText('Account Management', type: TextType.title, isBold: false), onPressed: onPressed),
              SettingsTile.navigation(leading: const Icon(Icons.security), title: const AppText('Security', type: TextType.title, isBold: false), onPressed: onPressed),
            ],
          ),
          SettingsSection(
            title: const AppText('Settings'),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: AppText(L.current.language, type: TextType.title, isBold: false),
                value: AppText(LocaleNames.of(context)?.nameOf(language.value), type: TextType.text, color: context.theme.extension<CustomTheme>()?.disabled),
                onPressed: (_) => ref.nav.push(const SettingLanguageRoute()),
              ),
              SettingsTile.navigation(
                leading: Icon(isDarkMode == true ? Icons.brightness_4_outlined : Icons.dark_mode_outlined),
                title: const AppText('Theme', type: TextType.title, isBold: false),
                value: AppText(
                    theme == 0
                        ? 'Default System'
                        : theme == 1
                            ? 'Dark Mode'
                            : 'Light Mode',
                    type: TextType.text,
                    color: context.theme.extension<CustomTheme>()?.disabled),
                onPressed: (_) => ref.nav.push(const SettingThemeRoute()),
              ),
              SettingsTile.navigation(leading: const Icon(Icons.delete), title: const AppText('Delete Account', type: TextType.title, isBold: false), trailing: const SizedBox.shrink(), onPressed: onPressDeleteAccount),
            ],
          ),
          SettingsSection(
            tiles: [SettingsTile.navigation(leading: const Icon(Icons.logout), title: const AppText('Logout', type: TextType.title, isBold: false), trailing: const SizedBox.shrink(), onPressed: onPressLogout)],
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class SettingThemePage extends ConsumerWidget {
  const SettingThemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    void onPressed(int val) {
      Log.d('SettingThemePage > onPressed: $val');
      ref.update(themeModeProvider, (_) => val);
    }

    return AppScaffold(
      appBar: AppTopBar(text: L.current.theme),
      body: SettingsList(
        applicationType: ApplicationType.both,
        contentPadding: const EdgeInsets.all(10),
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile.navigation(title: const AppText('Default System'), trailing: theme == 0 ? const Icon(Icons.check) : null, onPressed: (_) => onPressed(0)),
              SettingsTile.navigation(title: const AppText('Light Mode'), trailing: theme == 1 ? const Icon(Icons.check) : null, onPressed: (_) => onPressed(1)),
              SettingsTile.navigation(title: const AppText('Dark Mode'), trailing: theme == 2 ? const Icon(Icons.check) : null, onPressed: (_) => onPressed(2)),
            ],
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class SettingLanguagePage extends ConsumerWidget {
  const SettingLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageCodeProvider);

    void onPressed(String languageCode) {
      Log.d('SettingLanguagePage > onPressed: $languageCode');
      ref.update<LanguageCode>(languageCodeProvider, (state) => LanguageCode.fromValue(languageCode));
    }

    return AppScaffold(
      appBar: AppTopBar(text: L.current.language),
      body: SettingsList(
        applicationType: ApplicationType.both,
        sections: S.delegate.supportedLocales
            .map((e) => SettingsSection(
                  tiles: [
                    SettingsTile.navigation(
                      title: AppText(LocaleNames.of(context)?.nameOf(e.languageCode)),
                      trailing: language.value == e.languageCode ? const Icon(Icons.check) : null,
                      onPressed: (_) => onPressed(e.languageCode),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
