import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appPopupInfo, AppNavigator navigator) {
    return appPopupInfo.when(
      infoDialog: (message, onPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
                text: S.current.ok,
                onPressed: () {
                  navigator.pop(useRootNavigator: true);
                  onPressed?.call();
                }),
          ],
          message: message,
        );
      },
      listOptionDialog: (title, content, onPressed) {
        return CommonDialog(
          title: title,
          content: content,
          actions: [
            PopupButton(
                text: S.current.ok,
                onPressed: () {
                  navigator.pop(useRootNavigator: true);
                  onPressed?.call();
                }),
          ],
        );
      },
      confirmDialog: (title, message, onPressedCancel, onPressedOk) {
        return CommonDialog(
          title: title,
          actions: [
            PopupButton(
              text: S.current.cancel,
              onPressed: onPressedCancel ?? () => navigator.pop(useRootNavigator: true),
            ),
            PopupButton(
                text: S.current.ok,
                onPressed: () {
                  navigator.pop(useRootNavigator: true);
                  onPressedOk?.call();
                }),
          ],
          message: message,
        );
      },
      errorWithRetryDialog: (message, onRetryPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: S.current.cancel,
              onPressed: () => navigator.pop(useRootNavigator: true),
            ),
            PopupButton(
              text: S.current.retry,
              onPressed: () {
                navigator.pop(useRootNavigator: true);
                onRetryPressed?.call();
              },
              isDefault: true,
            ),
          ],
          message: message,
        );
      },
      requiredLoginDialog: () => CommonDialog.adaptive(
        title: S.current.login,
        message: S.current.login,
        actions: [
          PopupButton(
            text: S.current.cancel,
            onPressed: () => navigator.pop(useRootNavigator: true),
          ),
          PopupButton(
            text: S.current.login,
            onPressed: Func0(() async {
              await navigator.pop(useRootNavigator: true);
              await navigator.push(const LoginRoute());
            }),
          ),
        ],
      ),
    );
  }
}
