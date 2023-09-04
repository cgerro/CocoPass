import 'password_config.dart';
import 'list_password.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _obscureText = true;  // État pour le texte masqué ou visible

  int _passwordLength = 16;
  bool _useLowercase = true;
  bool _useUppercase = true;
  bool _useSpecialChars = true;
  bool _useNumber = true;

  void updatePasswordConfig(int length, bool useLowercase, bool useUppercase, bool useNumber, bool useSpecialChars) {
    setState(() {
      _passwordLength = length;
      _useLowercase = useLowercase;
      _useUppercase = useUppercase;
      _useNumber = useNumber;
      _useSpecialChars = useSpecialChars;
    });
  }

  String generatePassword() {
    String chars = "";

    if (_useLowercase) {
      chars += "abcdefghijklmnopqrstuvwxyz";
    }
    if (_useUppercase) {
      chars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    }
    if (_useSpecialChars) {
      chars += "!@#\$%^&*()[]{}:;<>,.?~";
    }
    if (_useNumber) {
      chars += "0123456789";
    }

    final random = Random.secure();
    String result = '';
    for (var i = 0; i < _passwordLength; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  void _addAccountToFirestore() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if a user is logged in
    if (currentUser != null) {
      // Use this user's ID
      String userID = currentUser.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(userID).collection('comptes').add({
        'login': _loginController.text,
        'password': _passwordController.text,
        'serviceName': _serviceNameController.text,
        'note': _noteController.text,
      });

      // Check if the context is still valid (i.e., the widget is still in the tree)
      if (mounted) {
        // Redirect to the PasswordListScreen after successful addition
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PasswordListScreen()),
        );
      }
    } else {
      // Handle the error - no user logged in
      print("No user logged in");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un mot de passe'),
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
                  controller: _serviceNameController,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    builder: (context) => PasswordConfigScreen(updatePasswordConfig: updatePasswordConfig),
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