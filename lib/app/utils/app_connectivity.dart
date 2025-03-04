import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

final appConnectivityProvider = Provider<AppConnectivity>((ref) => getIt.get<AppConnectivity>());

@LazySingleton()
class AppConnectivity {
  Future<bool> get isNetworkAvailable async {
    final result = await Connectivity().checkConnectivity();
    return _isNetworkAvailable(result);
  }

  Stream<bool> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged.map((event) {
      return _isNetworkAvailable(event);
    });
  }

  bool _isNetworkAvailable(List<ConnectivityResult> result) {
    if (result.length == 1 && result.first == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  //   @override
//   StreamSubscription<dynamic> subscriptionConnectivity() {
//     return Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
//       _isConnected = result.all((x) => x != ConnectivityResult.none);
//       Log.w('connected: $_isConnected - $result');
//     });
//   }
}
