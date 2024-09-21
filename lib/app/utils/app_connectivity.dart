import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

final appConnectivityProvider = Provider<AppConnectivity>((ref) => getIt.get<AppConnectivity>());

@LazySingleton()
class AppConnectivity {
  Future<bool> get isNetworkAvailable async {
    final result = await Connectivity().checkConnectivity();
    return result.all((x) => x != ConnectivityResult.none);
  }

  Stream<bool> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map((event) {
      return event.all((x) => x != ConnectivityResult.none);
    });
  }

  //   @override
//   StreamSubscription<dynamic> subscriptionConnectivity() {
//     return Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
//       _isConnected = result.all((x) => x != ConnectivityResult.none);
//       Log.w('connected: $_isConnected - $result');
//     });
//   }
}
