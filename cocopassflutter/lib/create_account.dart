import 'dart:math';
import 'package:cocopass/clipboarddelete.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _websiteNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _obscureText = true;  // État pour le texte masqué ou visible

  // Génère un mot de passe aléatoire de 16 caractères
  String generatePassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()[]{}:;<>,.?~";
    Random rnd = Random();
    String result = "";
    for (var i = 0; i < 16; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  void _addAccountToFirestore() async {
    String userID = "gens1";  // Remplacez ceci par l'ID d'utilisateur obtenu via Firebase Authentication

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('Users').doc(userID).collection('info').add({
      'login': _loginController.text,
      'password': _passwordController.text,
      'website': _websiteController.text,
      'websiteName': _websiteNameController.text,
      'note': _noteController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte'),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          // Génère un nouveau mot de passe et le met dans le champ de texte
                          _passwordController.text = generatePassword();
                        });
                      },
                    )
                  ],
                ),
                TextField(
                  controller: _websiteController,
                  decoration: InputDecoration(
                    labelText: 'Site Internet',
                  ),
                ),
                TextField(
                  controller: _websiteNameController,
                  decoration: InputDecoration(
                    labelText: 'Nom du service',
                  ),
                ),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Note',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Logique pour annuler et revenir à la page principale
                        Navigator.pop(context);  // Retour à la page précédente
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.red,
                      ),
                      child: Text('ANNULER', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addAccountToFirestore();
                        // Logique pour ajouter le compte
                        // Vous pouvez insérer la logique de validation et d'ajout de compte ici
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text('AJOUTER', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                // Naviguer vers l'écran PasswordGenerateScreen
                // Assurez-vous que cette classe est importée ou définie
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              child: Text(
                'Paramétrer la génération du MDP',
                style: TextStyle(
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}