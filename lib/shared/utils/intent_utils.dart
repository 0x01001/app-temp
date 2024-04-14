import 'package:url_launcher/url_launcher.dart';

class IntentUtils {
  static Future<bool> openBrowserURL({required String url, bool inApp = false}) async {
    final uri = Uri.parse(url);
    return await canLaunchUrl(uri)
        ? await launchUrl(
            uri,
            mode: inApp ? LaunchMode.inAppWebView : LaunchMode.platformDefault,
            webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
          )
        : false;
  }
}
