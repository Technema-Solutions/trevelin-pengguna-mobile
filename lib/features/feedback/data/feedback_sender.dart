import 'package:url_launcher/url_launcher.dart';

/// Abstraction for sending feedback information.
abstract class FeedbackSender {
  Future<void> send(String subject, String body);
}

/// Simple implementation that launches the mail client.
class EmailFeedbackSender implements FeedbackSender {
  EmailFeedbackSender({this.to = 'support@trevelin.example'});

  final String to;

  @override
  Future<void> send(String subject, String body) async {
    final uri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {'subject': subject, 'body': body},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
