import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../index.dart';

class HomeState extends BaseState {
  bool? isLoading;
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, AppState<HomeState>>((ref) => HomeProvider(ref));

class HomeProvider extends BaseProvider<HomeState> {
  HomeProvider(this._ref) : super(AppState(data: HomeState()));

  final Ref _ref;

  Future<void> init() async {}
}
