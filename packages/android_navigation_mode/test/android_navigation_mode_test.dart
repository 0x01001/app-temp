import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_navigation_mode/android_navigation_mode.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_navigation_mode');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AndroidNavigationMode.getNavigationMode, isA<DeviceNavigationMode>());
  });
}
