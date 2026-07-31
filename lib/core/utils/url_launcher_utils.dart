import 'package:leave_management_system/core/networking/errors/exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> openExternalUrl(String attachmetUrl) async {
    final Uri url = Uri.parse(attachmetUrl);
    final bool isLaunched = await launchUrl(url, mode: LaunchMode.inAppWebView);
    if (!isLaunched) {
      throw UrlLaunchException(attachmetUrl);
    }
  }
}
