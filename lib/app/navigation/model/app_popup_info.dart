import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_popup_info.freezed.dart';

/// dialog, bottomsheet
@freezed
class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.infoDialog({@Default('') String message, void Function()? onPressed}) = _InfoDialog;

  const factory AppPopupInfo.listOptionDialog({@Default('') String title, Widget? content, void Function()? onPressed}) = _ListOptionDialog;

  const factory AppPopupInfo.confirmDialog({@Default('') String title, @Default('') String message, void Function()? onPressedCancel, void Function()? onPressedOk}) = _ConfirmDialog;

  const factory AppPopupInfo.errorWithRetryDialog({@Default('') String message, void Function()? onPressedRetry}) = _ErrorWithRetryDialog;

  const factory AppPopupInfo.requiredLoginDialog() = _RequiredLoginDialog;
}
