import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../resources/index.dart';
import '../../../index.dart';

enum PopupType {
  android,
  ios,
  adaptive,
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({this.commonPopupType = PopupType.adaptive, this.actions = const <PopupButton>[], this.title, this.message, this.content, super.key});

  const CommonDialog.android({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, Key? key}) : this(commonPopupType: PopupType.android, actions: actions, title: title, message: message, content: content, key: key);
  const CommonDialog.ios({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, Key? key}) : this(commonPopupType: PopupType.ios, actions: actions, title: title, message: message, content: content, key: key);
  const CommonDialog.adaptive({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, Key? key}) : this(commonPopupType: PopupType.adaptive, actions: actions, title: title, message: message, content: content, key: key);

  final PopupType commonPopupType;
  final List<PopupButton> actions;
  final String? title;
  final String? message;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    switch (commonPopupType) {
      case PopupType.android:
        return _buildAndroidDialog(context);
      case PopupType.ios:
        return _buildIosDialog(context);
      case PopupType.adaptive:
        return Platform.isIOS ? _buildIosDialog(context) : _buildAndroidDialog(context);
    }
  }

  List<Widget>? _buildActionsWidget(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const height = 45.0;

    final List<Widget> list = [];
    for (var i = 0; i < actions.length; i++) {
      list.add(Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
            splashFactory: NoSplash.splashFactory,
            enableFeedback: false,
          ),
          onPressed: actions[i].onPressed,
          child: AppText(actions[i].text ?? S.current.ok, type: TextType.content, color: actions[i].text == S.current.ok ? scheme.secondary : null),
        ),
      ));
      if (actions.length > 1 && i == 0) {
        list.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: SizedBox(
            height: height,
            child: VerticalDivider(width: 1),
          ),
        ));
      }
    }
    return [
      const Divider(height: 1),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: list,
          ),
        ),
      ),
    ];
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>();
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: theme?.backgroundPopup,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      actionsAlignment: MainAxisAlignment.end,
      actions: _buildActionsWidget(context),
      title: Center(child: AppText(title ?? S.current.information, type: TextType.title)),
      content: message != null ? AppText(message ?? '', type: TextType.content, textAlign: TextAlign.center, maxLines: 999) : content,
    );
  }

  Widget _buildIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      actions: actions
          .map((e) => CupertinoDialogAction(
                onPressed: e.onPressed,
                child: AppText(e.text ?? S.current.ok, type: TextType.content),
              ))
          .toList(growable: false),
      title: AppText(title ?? S.current.information, type: TextType.title),
      content: message != null ? AppText(message ?? '', type: TextType.content) : content,
    );
  }
}
