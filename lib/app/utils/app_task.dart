// import 'dart:isolate';

// import 'package:flutter/services.dart';
// import 'package:get_it/get_it.dart';

// import '../../domain/index.dart';
// import '../../shared/index.dart';
// import '../di/di.dart' as di;

// // Parse Json => compute
// // Encrypt/Decrypt => Isolate
// // Image Processing => Isolate
// class Task {
//   Task._();

//   static Future<void> create<T>({required TaskModel<T> model, Function(T)? callback}) async {
//     final receive = ReceivePort();
//     final param = model.copyWith(sendPort: receive.sendPort, token: RootIsolateToken.instance!);
//     try {
//       await Isolate.spawn(
//         process,
//         param,
//         errorsAreFatal: true,
//         // onExit: receive.sendPort,
//         onError: receive.sendPort,
//       );
//     } on Object {
//       receive.close();
//     }
//     // // get only the first element like this
//     // final computedData = await receive.first;
//     // callback?.call(computedData);

//     // get more data you can use listen method
//     receive.listen((response) {
//       // isolate.kill(priority: Isolate.immediate);
//       // isolate = null;
//       callback?.call(response);
//     });
//   }

//   static Future<void> process<T>(TaskModel<T> model) async {
//     Log.d('Task > process started: ${model.token.hashCode}');
//     Repository? repository;
//     if (model.isEnableInjection == true) {
//       try {
//         BackgroundIsolateBinaryMessenger.ensureInitialized(model.token!);
//         await di.configureInjection();
//         repository = GetIt.instance.get<Repository>();
//       } catch (e) {
//         Log.d('Task > process: $e');
//       }
//     }
//     // action
//     final result = await model.action?.call(repository, model.param);
//     Log.d('Task > process finished: ${model.token.hashCode}');
//     // remember there is no return, just sending to listener defined defore.
//     // model.sendPort?.send(result);

//     //https://api.dart.dev/stable/2.19.2/dart-isolate/SendPort/send.html
//     Isolate.exit(model.sendPort, result);
//   }
// }

// class TaskModel<T> {
//   SendPort? sendPort;
//   RootIsolateToken? token;
//   Future<T> Function(Repository? repository, List<dynamic>? param)? action;
//   List<dynamic>? param;
//   bool? isEnableInjection;

//   TaskModel({this.sendPort, this.action, this.param, this.token, this.isEnableInjection = true});

//   TaskModel<T> copyWith({
//     SendPort? sendPort,
//     Future<T> Function(Repository? repository, List<dynamic>? param)? action,
//     List<dynamic>? param,
//     bool? isEnableInjection,
//     RootIsolateToken? token,
//   }) {
//     return TaskModel(
//       sendPort: sendPort ?? this.sendPort,
//       action: action ?? this.action,
//       param: param ?? this.param,
//       token: token ?? this.token,
//       isEnableInjection: isEnableInjection ?? this.isEnableInjection,
//     );
//   }
// }
