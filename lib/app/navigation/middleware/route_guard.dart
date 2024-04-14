import 'package:auto_route/auto_route.dart';
// import 'package:injectable/injectable.dart';

import '../../../domain/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

// @Injectable()
class RouteGuard extends AutoRouteGuard {
  bool get _isLoggedIn => getIt.get<UserRepository>().isLoggedIn; //TODO: call api check token

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    Log.d('onNavigation: ${_isLoggedIn} - ${router.current.name}');
    if (_isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
      resolver.next(false);
    }
  }
}
