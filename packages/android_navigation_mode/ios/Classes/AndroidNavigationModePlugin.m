#import "AndroidNavigationModePlugin.h"
#if __has_include(<android_navigation_mode/android_navigation_mode-Swift.h>)
#import <android_navigation_mode/android_navigation_mode-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "android_navigation_mode-Swift.h"
#endif

@implementation AndroidNavigationModePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAndroidNavigationModePlugin registerWithRegistrar:registrar];
}
@end
