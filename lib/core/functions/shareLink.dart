  import 'package:url_launcher/url_launcher.dart';

void shareViaTelegram(String url, String text) async {
    final encodedUrl = Uri.encodeComponent(url);
    final encodedText = Uri.encodeComponent(text);
    final telegramUrl =
        'https://t.me/share/url?url=$encodedUrl&text=$encodedText';
//_telegramClient.telegram.showScanQrPopup(infoTitle)
    if (await canLaunch(telegramUrl)) {
      await launch(telegramUrl);
    } else {
      throw 'Could not launch $telegramUrl';
    }
  }