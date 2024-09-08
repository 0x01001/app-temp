import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
// import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/index.dart';
import '../../shared/index.dart';

// import '../repository/source/database/generated/objectbox.g.dart' show getObjectBoxModel;

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  @preResolve
  Future<Isar> getIsar() async {
    final document = await getApplicationDocumentsDirectory();
    final isar = await Isar.open([PostEntitySchema], directory: document.path, inspector: Env.flavor != Flavor.prod); // /data/user/0/com.flutter.app.dev/app_flutter/default.isar
    return isar;
  }

  // @preResolve
  // Future<Store> getStore() async {
  //   final document = await getApplicationDocumentsDirectory();
  //   final path = '${document.path}/${DatabaseConstants.databaseName}';

  //   // applicable when store is from other isolate
  //   if (Store.isOpen(path)) {
  //     return Store.attach(getObjectBoxModel(), path);
  //   }
  //   return Store(getObjectBoxModel(), directory: path);
  // }
}
