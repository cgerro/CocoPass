import 'package:flutter/material.dart';

class ClipboardClearScreen extends StatelessWidget {
  const ClipboardClearScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Effacer le presse-papiers'),
      ),
      body: Center(
        child: Text('Écran de modification de l\'effacement du presse-papiers'),
      ),
    );
  }
}
