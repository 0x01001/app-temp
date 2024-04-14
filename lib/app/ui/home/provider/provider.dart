import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

part 'provider.g.dart';

@Riverpod()
class Home extends _$Home with Base {
  @override
  Future<void> build() async {
    Log.d('HomeProvider > build');
  }

  Future<List<PostEntity>?> loadData() async {
    final result = await postRepository.getListPost();

    return result;
  }
}

// @riverpod
// class UserList extends _$UserList {
//   // static final _log = LoggerFactory.logger('UserList');

//   @override
//   Future<IList<DataUser>> build({required String lampId}) {
//     Log.d('UserList > build()');
//     final result = [const DataUser(id: '1', email: 'test')].toIList();
//     return Future.value(result);
//   }
// }

@riverpod
Future<void> loadData(LoadDataRef ref) async {
  // final token = await getIt.get<Repository>().getAccessToken();
  // if (token.isNotEmpty) {
  //   final result = await ref.read(authProvider.notifier).loginWithToken(token);
  //   if (result == true) {}
  // }
}
