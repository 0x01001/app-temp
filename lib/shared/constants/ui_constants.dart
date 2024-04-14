import 'package:flutter/services.dart';

class UiConstants {
  const UiConstants._();

  /// shimmer
  static const shimmerItemCount = 20;

  /// loading
  static const loadingTimeout = 20000;

  /// material app
  static const materialAppTitle = 'My App';
  static const taskMenuMaterialAppColor = Color.fromARGB(255, 153, 154, 251);

  /// orientation
  static const mobileOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const tabletOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  /// status bar color
  static const systemUiOverlay = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Color.fromARGB(255, 255, 255, 255),
  );

  static const textFieldTextStyleHeight = 1.3;

  static const defaultDarkMode = false;
  static const defaultSizeButton = 45.0;
  static const defaultSizeTextInput = 45.0;

  // device
  static const designDeviceWidth = 375.0;
  static const designDeviceHeight = 667.0;

  static const maxMobileWidth = 450;
  static const maxTabletWidth = 900;

  static const maxMobileWidthForDeviceType = 550;

  // paging
  static const initialPage = 0;
  static const itemsPerPage = 10;
  static const defaultInvisibleItemsThreshold = 3;
  static const maxItemsPerRow = 3;
  static const paddingItemsGrid = 10.0;
  static const endReachedThreshold = 200.0;

  // downloading
  static const limitActivedDownload = 3;

  // UI
  static const borderHeight = 0.5;
}
