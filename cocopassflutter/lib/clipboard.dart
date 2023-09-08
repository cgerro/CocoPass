import 'package:clipboard/clipboard.dart';

abstract class ClipboardManager {
  static const int defaultClearTime = 30;

  static void copyToClipboard(String text) {
    FlutterClipboard.copy(text);
  }

  static void clearClipboard(int? durationInSeconds) {
    final duration = Duration(
      seconds: durationInSeconds ?? defaultClearTime,
    );
    Future.delayed(duration, () async {
      await FlutterClipboard.copy('');
    });
  }
}
