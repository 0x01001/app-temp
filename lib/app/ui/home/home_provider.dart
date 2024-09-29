import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class HomeState extends BaseState {
  bool? isLoading; // for shimmer
  List<UserModel>? users;
  HomeState({this.isLoading = true, this.users = const []});

  HomeState copyWith({bool? isLoading, List<UserModel>? users}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, AppState<HomeState>>((ref) => HomeProvider(ref));

class HomeProvider extends BaseProvider<HomeState> {
  HomeProvider(this._ref) : super(AppState(data: HomeState()));

  final Ref _ref;

  Future<void> init() async {
    loadData(isRefresh: true);
  }

  Future<void> loadData({bool isRefresh = false}) async {
    return await runSafe(
      action: () async {
        data = data?.copyWith(isLoading: isRefresh);
        final result = await _ref.api.getListUser();
        data = data?.copyWith(isLoading: false, users: result?.data ?? []);
      },
      handleLoading: false,
      handleError: false,
      onCompleted: () async {
        data = data?.copyWith(isLoading: false);
      },
    );
  }
}
