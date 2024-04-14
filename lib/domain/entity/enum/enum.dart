import 'package:flutter/material.dart';

import '../../../resources/index.dart';

// enum AppRoute {
//   login,
//   main,
// }

// enum Gender {
//   male(ServerConstants.male),
//   female(ServerConstants.female),
//   other(ServerConstants.other),
//   unknown(ServerConstants.unknown);

//   const Gender(this.serverValue);
//   final int serverValue;
// }

enum GenderType {
  male,
  female,
  other,
}

enum ConfigType {
  khcn,
  sme,
}

// enum LanguageCode {
//   en(localeCode: LocaleConstants.en, serverValue: ServerConstants.en),
//   ja(localeCode: LocaleConstants.ja, serverValue: ServerConstants.ja);

//   const LanguageCode({
//     required this.localeCode,
//     required this.serverValue,
//   });
//   final String localeCode;
//   final String serverValue;

//   static LanguageCode get defaultValue => en;
// }

enum NotificationType {
  unknown,
  newPost,
  liked,
}

enum DownloadType {
  pending,
  downloading,
  completed,
}

enum ItemType {
  downloading,
  completed,
}

enum BottomTab {
  home(icon: Icon(Icons.home), activeIcon: Icon(Icons.home)),
  // favorite(icon: Icon(Icons.favorite), activeIcon: Icon(Icons.favorite)),
  empty(icon: SizedBox.shrink(), activeIcon: SizedBox.shrink()),
  // download(icon: Icon(Icons.download), activeIcon: Icon(Icons.download)),
  setting(icon: Icon(Icons.settings), activeIcon: Icon(Icons.settings));

  const BottomTab({
    required this.icon,
    required this.activeIcon,
  });
  final Widget icon;
  final Widget activeIcon;

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.home;
      case BottomTab.empty:
        return '';
      case BottomTab.setting:
        return S.current.setting;
    }
  }
}
