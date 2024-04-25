// import 'package:adaptive_dialog/adaptive_dialog.dart';
// import 'package:flutter/material.dart';

// import '../index.dart';

// Future<dynamic> showAlert({required BuildContext context, required String message, required String okButton, String? title, String? cancelButton}) async {
//   final actions = <Widget>[];

//   if (cancelButton != null) {
//     actions.add(TextButton(
//       child: AppText(cancelButton, type: TextType.title),
//       onPressed: () {
//         Navigator.of(context).pop(false);
//       },
//     ));
//   }
//   actions.add(TextButton(
//     child: AppText(okButton, type: TextType.title),
//     onPressed: () {
//       Navigator.of(context).pop(true);
//     },
//   ));

//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: title != null ? AppText(title, type: TextType.header) : null,
//         content: AppText(message, type: TextType.content),
//         actions: actions,
//       );
//     },
//   );
// }

// Future<void> showConfirmDialog(BuildContext context, String title, String description, String confirmLabel, String cancelLabel, {Function? onConfirm, Function? onCancel, bool isDestructiveAction = true, bool enableDismiss = true}) async {
//   final result = await showOkCancelAlertDialog(
//     context: context,
//     title: title,
//     message: description,
//     isDestructiveAction: isDestructiveAction,
//     okLabel: confirmLabel,
//     cancelLabel: cancelLabel,
//     barrierDismissible: enableDismiss,
//     style: AdaptiveStyle.iOS,
//   );
//   if (result == OkCancelResult.ok) {
//     if (onConfirm != null) onConfirm.call();
//   } else {
//     if (onCancel != null) onCancel.call();
//   }
// }

// Future<void> showInfoDialog(BuildContext context, String description, {String? confirmLabel, Function? onConfirm}) async {
//   final result = await showOkAlertDialog(context: context, message: description, okLabel: confirmLabel, style: AdaptiveStyle.iOS);
//   if (result == OkCancelResult.ok) {
//     if (onConfirm != null) onConfirm.call();
//   }

//   // final Widget confirmButton = ButtonText(
//   //   padding: const EdgeInsets.all(10),
//   //   isUnderline: false,
//   //   text: confirmLabel,
//   //   onPressed: () {
//   //     Navigator.of(context).pop(); // dismiss dialog
//   //   },
//   // );
//   // // set up the AlertDialog
//   // final alert = AlertDialog(
//   //   title: Text(title),
//   //   content: Text(description),
//   //   actions: [confirmButton],
//   //   // actionsAlignment: MainAxisAlignment.center,
//   // );
//   // // show the dialog
//   // showDialog(
//   //   context: context,
//   //   builder: (BuildContext context) {
//   //     return alert;
//   //   },
//   // );
// }
