import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/index.dart';
import '../../index.dart';
import '../../shared_view/app_list.dart';
import '../auth/provider/provider.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('SettingPage > build');
    // const bool _switchValue = false;
    // final _appProvider = ref.watch(appProvider);

    Future<void> onPressLogout() async {
      final result = await getIt.get<AppNavigator>().showDialog(AppPopupInfo.confirmDialog(
            title: 'Confirm',
            message: 'Are you sure you want to log out?',
            onPressedOk: () async {
              await ref.read(authProvider.notifier).logout();
              await getIt.get<AppNavigator>().replace(const LoginRoute());
            },
          ));
      Log.d('on close popup..: $result');
    }

    void onChanged(bool? val) {
      if (val == true) {
        AdaptiveTheme.of(context).setDark();
      } else {
        AdaptiveTheme.of(context).setLight();
      }
    }

    void handleTap() {
      Log.d('tap cell');
    }

    List<AppSectionData> _buildList() {
      return [
        AppSectionData(headerTitle: 'Account', itemList: [
          AppItemData(title: 'Account Management', accessoryType: AppListCellAccessoryType.detail, onTap: handleTap),
          AppItemData(title: 'Security', accessoryType: AppListCellAccessoryType.detail, onTap: handleTap),
        ]),
        AppSectionData(headerTitle: 'Settings', itemList: [
          AppItemData(title: 'Language', accessoryType: AppListCellAccessoryType.detail, accessoryString: 'English', onTap: handleTap),
          AppItemData(
            title: 'Eye Protection Mode',
            accessoryType: AppListCellAccessoryType.switchOnOff,
            onChanged: onChanged,
            accItemValue: AdaptiveTheme.of(context).mode.isDark,
          ),
          AppItemData(
            title: 'Automatically Clear Cache',
            subtitle: 'Clean up every 10 days',
            accessoryType: AppListCellAccessoryType.checkmark,
            onTap: handleTap,
            selected: true,
          )
        ]),
        AppSectionData(itemList: [
          AppItemData(
            cellType: AppListCellType.button,
            buttonTitle: 'Logout',
            buttonTitleColor: Colors.red,
            onTap: onPressLogout,
          ),
        ])
      ];
    }

    return AppScaffold(
      appBar: AppTopBar(text: 'Setting'),
      body: AppListView(
        shrinkWrap: true,
        sections: _buildList(),
      ),

      // ListView.separated(
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext context, int index) {
      //     return cells[index];
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Divider(color: Theme.of(context).extension<CustomTheme>()?.brandColor, height: 1);
      //   },
      //   itemCount: 3,
      // ),

      // Column(
      //   children: [
      //     //TODO: change to option system, dark, light
      //     AnimatedSwitcher(
      //       duration: const Duration(seconds: 1),
      //       child: SwitchListTile.adaptive(
      //         // visualDensity: const VisualDensity(vertical: -3),
      //         contentPadding: const EdgeInsets.all(0),
      //         title: Transform.translate(offset: Offset(-15, 0), child: AppText(S.current.darkTheme, type: TextType.content)),
      //         value: AdaptiveTheme.of(context).mode.isDark,
      //         onChanged: onChanged,
      //         secondary: const Icon(Icons.lightbulb_outline),
      //       ),
      //     ),
      //     SwitchListTile.adaptive(
      //       // visualDensity: const VisualDensity(vertical: -3),
      //       contentPadding: const EdgeInsets.all(0),
      //       title: Transform.translate(offset: Offset(-15, 0), child: AppText(S.current.japanese, type: TextType.content)),
      //       value: _appProvider.value?.languageCode == LocaleConstants.ja,
      //       onChanged: (val) => ref.read(appProvider.notifier).setLanguage(val ? LocaleConstants.ja : LocaleConstants.en),
      //       secondary: const Icon(Icons.language_outlined),
      //     ),
      //     AppButton(S.current.logout, backgroundColor: Colors.redAccent, color: Colors.white, onPressed: onPressLogout),
      //   ],
      // ),
    );
  }
}
