import 'package:auto_route/annotations.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class SettingState extends BaseState {
  SettingState();
}

final settingProvider = StateNotifierProvider.autoDispose<SettingProvider, AppState<SettingState>>((ref) => SettingProvider());

class SettingProvider extends BaseProvider<SettingState> {
  SettingProvider() : super(AppState(data: SettingState()));
}

@RoutePage()
class SettingPage extends BasePage {
  const SettingPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<SettingProvider, AppState<SettingState>> get provider => settingProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    Log.d('SettingPage > build');
    final user = ref.watch(currentUserProvider);
    final color = context.colors.inverseSurface;

    Future<void> onPressLogout() async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Are you sure you want to log out?',
        onConfirm: () {
          ref.read(authProvider.notifier).logout();
        },
      ));
      Log.d('on close popup..: $result');
    }

    Future<void> onPressDeleteAccount() async {
      final result = await ref.nav.showDialog(AppPopup.confirmDialog(
        'Confirm',
        message: 'Your data will be deleted and cannot be recovered.\nAre you sure you want to delete account?',
        onConfirm: () {
          ref.read(authProvider.notifier).deleteAccount();
        },
      ));
      Log.d('on close popup..: $result');
    }

    return AppScaffold(
      appBar: AppTopBar(text: S.current.setting),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.id?.isNotEmpty == true)
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    AppAvatar(text: user.email ?? ''),
                    const SizedBox(width: 16),
                    Flexible(child: AppText(user.name ?? '')),
                    const SizedBox(width: 10),
                    Flexible(child: AppText(user.email ?? '')),
                  ],
                ),
              ),
            if (user.id?.isNotEmpty == true)
              ListTile(
                title: AppText(S.current.editProfile, type: TextType.title, isBold: false),
                leading: Icon(Icons.person, color: color),
                trailing: Icon(Icons.arrow_forward_ios, color: color),
                onTap: () {},
              ),
            ListTile(
              title: AppText(S.current.notification, type: TextType.title, isBold: false),
              leading: Icon(Icons.notifications, color: color),
              trailing: Icon(Icons.arrow_forward_ios, color: color),
              onTap: () {},
            ),
            ListTile(
              title: AppText(S.current.download, type: TextType.title, isBold: false),
              leading: Icon(Icons.download, color: color),
              trailing: Icon(Icons.arrow_forward_ios, color: color),
              onTap: () {},
            ),
            ListTile(
              title: AppText(S.current.security, type: TextType.title, isBold: false),
              leading: Icon(Icons.security, color: color),
              trailing: Icon(Icons.arrow_forward_ios, color: color),
              onTap: () {},
            ),
            ListTile(
              title: AppText(S.current.privacyPolicy, type: TextType.title, isBold: false),
              leading: Icon(Icons.policy, color: color),
              trailing: Icon(Icons.arrow_forward_ios, color: color),
              onTap: () {},
            ),
            ListTile(
              title: AppText(S.current.language, type: TextType.title, isBold: false),
              leading: Icon(Icons.translate, color: color),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final lang = ref.watch(languageCodeProvider);
                      return AppText(languageToCountryCode[lang]?.language ?? 'English', color: appColor.grey5);
                    },
                  ),
                  AppSize.XS,
                  Icon(Icons.arrow_forward_ios, color: color),
                ],
              ),
              onTap: () => ref.nav.push(const SettingLanguageRoute()),
            ),
            ListTile(
              title: AppText(S.current.theme, type: TextType.title, isBold: false),
              leading: Icon(Icons.color_lens, color: color), // AppImage(appImage.iconShow.path, color: color),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final theme = ref.watch(themeModeProvider);
                      final text = theme == 0
                          ? S.current.defaultSystem
                          : theme == 1
                              ? S.current.lightMode
                              : S.current.darkMode;
                      return AppText(text, color: appColor.grey5);
                    },
                  ),
                  AppSize.XS,
                  Icon(Icons.arrow_forward_ios, color: color),
                ],
              ),
              onTap: () => ref.nav.push(const SettingThemeRoute()),
            ),
            if (user.id?.isNotEmpty == true)
              ListTile(
                title: AppText(S.current.deleteAccount, type: TextType.title, isBold: false, color: appColor.error),
                leading: Icon(Icons.delete, color: appColor.error),
                onTap: onPressDeleteAccount,
              ),
            if (user.id?.isNotEmpty == true)
              ListTile(
                title: AppText(S.current.logout, type: TextType.title, isBold: false),
                leading: Icon(Icons.logout, color: color),
                onTap: onPressLogout,
              ),
          ],
        ),
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
      ref.update(themeModeProvider, (_) => val);
    }

    return AppScaffold(
      appBar: AppTopBar(text: S.current.theme),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: AppText(S.current.defaultSystem, type: TextType.title, isBold: false),
              trailing: theme == 0 ? const Icon(Icons.check) : null,
              onTap: () => onPressed(0),
            ),
            ListTile(
              title: AppText(S.current.lightMode, type: TextType.title, isBold: false),
              trailing: theme == 1 ? const Icon(Icons.check) : null,
              onTap: () => onPressed(1),
            ),
            ListTile(
              title: AppText(S.current.darkMode, type: TextType.title, isBold: false),
              trailing: theme == 2 ? const Icon(Icons.check) : null,
              onTap: () => onPressed(2),
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class SettingLanguagePage extends ConsumerWidget {
  const SettingLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageCodeProvider);

    void onPressed(String languageCode) {
      ref.update(languageCodeProvider, (state) => languageCode);
    }

    return AppScaffold(
      appBar: AppTopBar(text: S.current.language),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AppString.delegate.supportedLocales
              .map((x) => ListTile(
                    leading: Container(
                      height: 16.0,
                      width: 22.0,
                      decoration: BoxDecoration(border: Border.all(color: appColor.grey5, width: Constant.borderHeight)),
                      child: ClipRRect(
                        child: CountryPickerUtils.getDefaultFlagImage(CountryPickerUtils.getCountryByIsoCode(languageToCountryCode[x.languageCode]?.code ?? 'US')),
                      ),
                    ),
                    title: AppText(languageToCountryCode[x.languageCode]?.language ?? 'English', type: TextType.title, isBold: false),
                    trailing: lang == x.languageCode ? const Icon(Icons.check) : null,
                    onTap: () => onPressed(x.languageCode),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
