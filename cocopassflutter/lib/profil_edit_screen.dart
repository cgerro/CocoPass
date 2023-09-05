import 'package:flutter/material.dart';

class ProfilEditScreen extends StatelessWidget {
  const ProfilEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier profil'),
      ),
      body: Center(
        child: Text('Écran de modification du profil'),
      ),
    );
  }
}
