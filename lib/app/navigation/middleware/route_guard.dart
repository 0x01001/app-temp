import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@Injectable()
class RouteGuard extends AutoRouteGuard {
  RouteGuard(this.appPreferences);

  final AppPreferences appPreferences;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    Log.d('[APP] onNavigation: ${appPreferences.isLoggedIn} - ${router.current.name}');
    if (appPreferences.isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
      resolver.next(false);
    }
  }
}
