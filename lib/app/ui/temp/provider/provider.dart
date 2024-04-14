import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/index.dart';
import '../../../../shared/index.dart';
import '../../../index.dart';

part 'provider.g.dart';

@Riverpod()
class Temp extends _$Temp with Base {
  @override
  Future<void> build() async {
    Log.d('TempProvider > build');
  }

  Future<List<PostEntity>?> loadData() async {
    final result = await postRepository.getListPost();
    return result;
  }

  Future<List<PostEntity>?> loadDataSafe() async {
    final result = await runSafe(action: () => postRepository.getListPost());
    return result;
  }
}
