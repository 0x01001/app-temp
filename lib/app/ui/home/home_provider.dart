import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class HomeState extends BaseState {
  HomeState({this.isLoading = true, this.users = const [], this.total});

  bool? isLoading; // for shimmer
  List<UserModel>? users;
  int? total;

  HomeState copyWith({bool? isLoading, List<UserModel>? users, int? total, String? keyword, List<FirebaseConversationModel>? conversationList}) {
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

  Future<void> init() async {}

  Future<void> loadData({bool? isRefresh = false, int? page, int? limit}) async {
    return await runSafe(
      action: () async {
        data = data?.copyWith(isLoading: isRefresh);
        final result = await _ref.api.getListUser(page: page, limit: limit);
        final users = result?.data ?? [];
        final List<UserModel>? list = isRefresh == true ? users : [...data?.users ?? [], ...users];
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
