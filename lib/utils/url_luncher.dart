import 'package:url_launcher/url_launcher.dart';

class Url {
  static launchURL(url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        universalLinksOnly: true,
      );

      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceWebView: true,
          forceSafariVC: true,
        );
      }
    } else {
      throw 'Could not launch $url';
    }
  }
}
