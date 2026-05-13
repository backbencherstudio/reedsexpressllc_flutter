import 'package:url_launcher/url_launcher.dart';

import '../../widgets/global_snackbar.dart';

class UrlLauncher {
  // Open website URL
  static Future<void> openUrl(String? url) async {
    if (url == null || url.isEmpty) {
      _showError("No URL provided");
      return;
    }

    try {
      Uri uri = Uri.parse(url);

      if (!uri.hasScheme) {
        uri = Uri.parse('https://$url');
      }

      await _launch(uri);
    } catch (e) {
      _showError("Failed to open link");
    }
  }

  // Open dial app
  static Future<void> makePhoneCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _showError("No phone number provided");
      return;
    }

    final Uri uri = Uri.parse('tel:$phoneNumber');

    try {
      await launchUrl(uri);
    } catch (e) {
      _showError("Cannot open dialer");
    }
  }

  // Open SMS app
  // static Future<void> sendSms(String? phoneNumber) async {
  //   if (phoneNumber == null || phoneNumber.isEmpty) {
  //     _showError("No phone number provided");
  //     return;
  //   }
  //
  //   final Uri uri = Uri(
  //     scheme: 'sms',
  //     path: phoneNumber,
  //   );
  //
  //   await _launch(uri);
  // }

  // Open email app
  // static Future<void> sendEmail({
  //   required String? email,
  //   String subject = '',
  //   String body = '',
  // }) async {
  //   if (email == null || email.isEmpty) {
  //     _showError("No email provided");
  //     return;
  //   }
  //
  //   final Uri uri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     queryParameters: {
  //       'subject': subject,
  //       'body': body,
  //     },
  //   );
  //
  //   await _launch(uri);
  // }

  // Open maps
  // static Future<void> openMap(String location) async {
  //   if (location.isEmpty) {
  //     _showError("No location provided");
  //     return;
  //   }
  //
  //   final Uri uri = Uri.parse(
  //     'https://www.google.com/maps/search/?api=1&query=$location',
  //   );
  //
  //   await _launch(uri);
  // }

  // Common launcher method
  static Future<void> _launch(Uri uri) async {
    try {
      if (!await canLaunchUrl(uri)) {
        _showError("Cannot open this link");
        return;
      }

      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      _showError("Something went wrong");
    }
  }

  static void _showError(String message) {
    globalSnackBar(
      title: 'Error',
      message: message,
    );
  }
}