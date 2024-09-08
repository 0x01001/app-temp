import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/index.dart';
import '../../shared/index.dart';
import '../index.dart';

class AppPopup {
  const AppPopup._({required this.builder, required this.id});

  final String id;
  final Widget Function(BuildContext, AppNavigator) builder;

  @override
  String toString() => id;

  static AppPopup errorDialog(String message) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () => navigator.pop(),
            child: AppText(S.current.ok),
          ),
        ],
        content: AppText(message),
      ),
    );
  }

  // ignore: prefer_named_parameters
  static AppPopup confirmDialog(String title, {VoidCallback? onConfirm, VoidCallback? onCancel}) {
    return AppPopup._(
      id: 'confirmDialog_$title',
      builder: (context, navigator) => AlertDialog.adaptive(
        title: AppText(
          title,
          // style: ts(
          //   color: color.black,
          //   fontSize: 14.rps,
          // ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              navigator.pop(result: false);
              onCancel?.call();
            },
            child: AppText(S.current.cancel),
          ),
          TextButton(
            onPressed: () {
              navigator.pop(result: true);
              onConfirm?.call();
            },
            child: AppText(S.current.ok),
          ),
        ],
      ),
    );
  }

  static AppPopup simpleDialog({required List<Widget> children, String? title}) {
    return AppPopup._(
      id: 'simpleDialog_$title',
      builder: (context, navigator) => AlertDialog.adaptive(
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(children.length * 2 - 1, (index) {
            return index % 2 == 0 ? children[index ~/ 2] : const AppDivider();
          }),
        ),
      ),
    );
  }

  static Widget simpleSelection({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        // onTap: onTap,
        child: AppText(
          title,
          // style: ts(
          //   color: color.black,
          //   fontSize: 14.rps,
          // ),
        ),
      ),
    );
  }

  static AppPopup errorWithRetryDialog({required String message, required VoidCallback? onRetryPressed}) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () => navigator.pop(),
            child: AppText(S.current.cancel),
          ),
          if (onRetryPressed != null)
            TextButton(
              onPressed: () {
                navigator.pop();
                onRetryPressed.call();
              },
              child: AppText(S.current.retry),
            ),
        ],
        content: AppText(message),
      ),
    );
  }

  static AppPopup requiredLoginDialog() {
    return AppPopup._(
      id: 'requiredLoginDialog',
      builder: (context, navigator) => AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () => navigator.pop(),
            child: AppText(S.current.cancel),
          ),
          TextButton(
            onPressed: () async {
              await navigator.replaceAll([const LoginRoute()]);
            },
            child: AppText(S.current.ok),
          ),
        ],
        content: const AppText('S.current.requiresRecentLogin'),
      ),
    );
  }

  static AppPopup forceLogout(String message) {
    return AppPopup._(
      id: 'forceLogout$message',
      builder: (context, navigator) => AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () {
              navigator.pop();
            },
            child: AppText(S.current.ok),
          ),
        ],
        content: AppText(message),
      ),
    );
  }

  static AppPopup changeImageOptionsBottomSheet() {
    return AppPopup._(
      id: 'changeImageOptionsBottomSheet',
      builder: (context, navigator) => CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            onPressed: () => navigator.pop(),
            child: AppText(S.current.ok),
          ),
          CupertinoDialogAction(
            onPressed: () => navigator.pop(),
            child: AppText(S.current.cancel),
          ),
        ],
      ),
    );
  }

  static AppPopup successSnackBar(String message) {
    return AppPopup._(
      id: 'successSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: Colors.green,
      ),
    );
  }

  static AppPopup errorSnackBar(String message) {
    return AppPopup._(
      id: 'errorSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: Colors.red,
      ),
    );
  }

  static AppPopup yesNoDialog({required String message, required VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'yesNoDialog_$message',
      builder: (context, navigator) => AlertDialog.adaptive(
        actions: [
          TextButton(
            onPressed: () => navigator.pop(),
            child: const AppText('S.current.no'),
          ),
          if (onPressed != null)
            TextButton(
              onPressed: () {
                navigator.pop();
                onPressed.call();
              },
              child: const AppText('S.current.yes'),
            ),
        ],
        content: AppText(message),
      ),
    );
  }

  static AppPopup renameConversationDialog({required String email, required Function(String nameChanged) onSubmit}) {
    return AppPopup._(
      id: 'renameConversationDialog_$email',
      builder: (context, navigator) {
        String nickname = '';

        return Dialog(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppText(
                      'S.current.rename',
                      // style: ts(
                      //   color: color.black,
                      //   fontSize: 18.rps,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          nickname = value;
                        });
                      },
                      decoration: InputDecoration(hintText: email),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => navigator.pop(),
                            child: AppText(S.current.cancel),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              navigator.pop();
                              onSubmit(nickname);
                            },
                            child: AppText(S.current.ok),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
