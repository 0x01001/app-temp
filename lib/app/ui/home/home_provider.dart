import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class HomeState extends BaseState {
  HomeState({this.isLoading = true, this.users = const [], this.total});

  bool? isLoading; // for shimmer
  List<UserModel>? users;
  int? total;

  HomeState copyWith({bool? isLoading, List<UserModel>? users, int? total}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      total: total ?? this.total,
    );
  }
}

final homeProvider = StateNotifierProvider.autoDispose<HomeProvider, AppState<HomeState>>((ref) => HomeProvider(ref));

class HomeProvider extends BaseProvider<HomeState> {
  HomeProvider(this._ref) : super(AppState(data: HomeState()));

  final Ref _ref;
  int _page = Constant.initialPage;

  Future<void> init() async {
    loadData(isRefresh: true);
  }

  Future<void> loadMore() async {
    _page++;
    await loadData();
  }

  Future<void> loadData({bool isRefresh = false}) async {
    if (isRefresh) _page = Constant.initialPage;
    return await runSafe(
      action: () async {
        data = data?.copyWith(isLoading: isRefresh);
        final result = await _ref.api.getListUser(page: _page);
        final users = result?.data ?? [];
        final List<UserModel>? list = isRefresh ? users : [...data?.users ?? [], ...users];
        data = data?.copyWith(isLoading: false, users: list, total: result?.total);
      },
      handleLoading: false,
      handleError: false,
      onCompleted: () async {
        data = data?.copyWith(isLoading: false);
      },
    );
  }
}
