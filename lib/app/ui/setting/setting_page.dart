import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Log.d('SettingPage > build');
    final isDarkMode = ref.watch(isDarkModeProvider);

    Future<void> onPressLogout() async {
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
          AppItemData(title: 'Eye Protection Mode', accessoryType: AppListCellAccessoryType.switchOnOff, onChanged: onChanged, accItemValue: isDarkMode),
          AppItemData(title: 'Automatically Clear Cache', subtitle: 'Clean up every 10 days', accessoryType: AppListCellAccessoryType.checkmark, selected: true, onTap: handleTap)
        ]),
        AppSectionData(itemList: [
          AppItemData(cellType: AppListCellType.button, buttonTitle: 'Logout', buttonTitleColor: Colors.red, onTap: onPressLogout),
        ])
      ];
    }

    return AppScaffold(
      appBar: AppTopBar(text: 'Setting'),
      body: AppListView(
        // shrinkWrap: true,
        sections: _buildList(),
      ),
    );
  }
}
