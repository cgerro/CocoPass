import 'package:flutter/material.dart';
import 'dart:async';
import 'clipboard.dart';

class ClipboardClearScreen extends StatefulWidget {
  const ClipboardClearScreen({Key? key}) : super(key: key);

  @override
  State<ClipboardClearScreen> createState() => _ClipboardClearScreenState();
}

class _ClipboardClearScreenState extends State<ClipboardClearScreen> {
  List<String> clearTimes = [
    '20 secondes',
    '30 secondes',
    '1 minute',
    '2 minutes'
  ];

  String selectedTime = '30 secondes';

  Timer? clipboardClearTimer;

  void setClipboardClearTimer() {
    clipboardClearTimer?.cancel();

    if (selectedTime == '20 secondes') {
      ClipboardManager.clearClipboard(20);
    } else if (selectedTime == '30 secondes') {
      ClipboardManager.clearClipboard(30);
    } else if (selectedTime == '1 minute') {
      ClipboardManager.clearClipboard(60);
    } else if (selectedTime == '2 minutes') {
      ClipboardManager.clearClipboard(120);
    }
  }

  Widget _detailBox(Widget child) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Effacer le presse-papiers'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _detailBox(Row(
              children: [
                Expanded(
                  child: Text(
                    'Sélectionnez le délai pour effacer le presse-papiers :',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTime = newValue!;
                    });
                  },
                  items: clearTimes.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                ),
              ],
            )),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                setClipboardClearTimer();
                // Message de confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Paramètres enregistrés avec succès.'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: const Text('ENREGISTRER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
