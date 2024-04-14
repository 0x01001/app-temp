// import 'dart:async';

// import 'package:background_downloader/background_downloader.dart';
// import 'package:injectable/injectable.dart';

// import '../../shared/shared.dart';

// @LazySingleton()
// class DownloadHelper {
//   //{void Function(Task task, NotificationType notificationType)? onNotificationTapCallback}
//   Future<void> init() async {
//     final result = await FileDownloader().configure(
//       globalConfig: [('requestTimeout', const Duration(seconds: 100))],
//       androidConfig: [('runInForegroundIfFileLargerThan', 10)],
//       iOSConfig: [
//         ('localize', {'Cancel': 'StopIt'})
//       ],
//     );
//     Log.d('DownloadHelper > init: $result');

//     // Registering a callback and configure notifications
//     FileDownloader()
//         .registerCallbacks(taskNotificationTapCallback: onNotificationTapCallback)
//         .configureNotificationForGroup(FileDownloader.defaultGroup,
//             // For the main download button
//             // which uses 'enqueue' and a default group
//             running: const TaskNotification('Download {filename}', 'File: {filename} - {progress} - speed {networkSpeed} and {timeRemaining} remaining'),
//             complete: const TaskNotification('Download {filename}', 'Download complete'),
//             error: const TaskNotification('Download {filename}', 'Download failed'),
//             paused: const TaskNotification('Download {filename}', 'Paused with metadata {metadata}'),
//             progressBar: true)
//         .configureNotification(
//             // for the 'Download & Open' dog picture
//             // which uses 'download' which is not the .defaultGroup
//             // but the .await group so won't use the above config
//             complete: const TaskNotification('Download {filename}', 'Download complete'),
//             tapOpensFile: false); // dog can also open directly from tap
//   }

//   /// Process the user tapping on a notification by printing a message
//   void onNotificationTapCallback(Task task, NotificationType notificationType) {
//     Log.d('Tapped notification $notificationType for taskId ${task.taskId}');
//   }
// }
