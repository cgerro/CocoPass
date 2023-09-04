import 'package:flutter/material.dart';

class MasterPasswordEditScreen extends StatelessWidget {
  const MasterPasswordEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier mot de passe master'),
      ),
      body: Center(
        child: Text('Écran de modification du mot de passe master'),
      ),
    );
  }
}
