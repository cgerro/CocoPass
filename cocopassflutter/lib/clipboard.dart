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
    // Définissez la durée du délai (30 secondes)
    Future.delayed(duration, () async {
      // Attendez 30 secondes, puis effacez le presse-papiers
      await FlutterClipboard.copy('');
      print('Presse-papiers effacé après 30 secondes');
    });
  }
}
