import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../resources/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

enum PopupType { android, ios, adaptive }

class CommonDialog extends StatelessWidget {
  const CommonDialog({this.commonPopupType = PopupType.adaptive, this.actions = const <PopupButton>[], this.title, this.message, this.content, this.contentPadding, super.key});

  const CommonDialog.android({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, Key? key}) : this(commonPopupType: PopupType.android, actions: actions, title: title, message: message, content: content, key: key);
  const CommonDialog.ios({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, Key? key}) : this(commonPopupType: PopupType.ios, actions: actions, title: title, message: message, content: content, key: key);
  const CommonDialog.adaptive({List<PopupButton> actions = const <PopupButton>[], String? title, String? message, Widget? content, EdgeInsets? contentPadding, Key? key})
      : this(commonPopupType: PopupType.adaptive, actions: actions, title: title, message: message, content: content, contentPadding: contentPadding, key: key);

  final PopupType commonPopupType;
  final List<PopupButton> actions;
  final String? title;
  final String? message;
  final Widget? content;
  final EdgeInsets? contentPadding;

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
          child: AppText(actions[i].text ?? S.current.ok, isBold: true, color: actions[i].text == S.current.ok ? scheme.primary : null),
        ),
      ));
      if (actions.length > 1 && i == 0) {
        list.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: SizedBox(height: height, child: VerticalDivider(width: 0.5)),
        ));
      }
    }
    return actions.isNotEmpty
        ? [
            const Divider(height: 0.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: SizedBox(
                height: height,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: list),
              ),
            ),
          ]
        : [];
  }

  Widget _buildAndroidDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: contentPadding ?? const EdgeInsets.all(Constant.defaultPadding),
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      titlePadding: title != null ? const EdgeInsets.fromLTRB(Constant.defaultPadding, Constant.defaultPadding, Constant.defaultPadding, 0) : EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.end,
      actions: _buildActionsWidget(context),
      title: title != null ? Center(child: AppText(title ?? S.current.information, type: TextType.title)) : null,
      content: message != null ? AppText(message ?? '', type: TextType.content, textAlign: TextAlign.center, maxLines: 999) : content,
    );
  }

  Widget _buildIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      actions: actions.map((e) => CupertinoDialogAction(onPressed: e.onPressed, child: AppText(e.text ?? S.current.ok, type: TextType.content))).toList(growable: false),
      title: title != null ? AppText(title ?? S.current.information, type: TextType.title) : null,
      content: message != null ? AppText(message ?? '', type: TextType.content) : content,
    );
  }
}
