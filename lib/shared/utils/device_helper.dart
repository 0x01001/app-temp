import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../index.dart';

final deviceHelperProvider = Provider<DeviceHelper>((ref) => getIt.get<DeviceHelper>());

@LazySingleton()
class DeviceHelper {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> get id async {
    // if (Platform.isIOS) {
    return await FlutterUdid.udid; // unique ID on iOS
    // } else {
    //   const _androidIdPlugin = AndroidId();
    //   final androidID = await _androidIdPlugin.getId();
    //   return androidID ?? ''; // unique ID on Android
    // }
  }

  Future<String?> get name async {
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.name;
    } else {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return '${androidInfo.brand} ${androidInfo.device}';
    }
  }

  DeviceType get type => MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.shortestSide < Constant.maxMobileWidthForDeviceType ? DeviceType.mobile : DeviceType.tablet;

  Future<bool> hasDynamicIsland() async {
    if (Platform.isIOS) {
      try {
        final iosInfo = await _deviceInfo.iosInfo;

        final dynamicIslandModels = [
          'iPhone14,3',
          'iPhone14,4',
          'iPhone15,2',
          'iPhone15,3',
          'iPhone15,4',
          'iPhone15,5',
          'iPhone16,1',
          'iPhone16,2',
          'iPhone16,3',
          'iPhone16,4',
        ];

        return dynamicIslandModels.contains(iosInfo.utsname.machine);
      } catch (e) {
        debugPrint('Error checking for dynamic island: $e');
        return false;
      }
    }
    return false;
  }
}
