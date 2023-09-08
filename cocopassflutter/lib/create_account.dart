import 'password_config.dart';
import 'list_password.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'globals.dart' as globals;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _obscureText = true; // État pour le texte masqué ou visible

  int _passwordLength = 16;
  bool _useLowercase = true;
  bool _useUppercase = true;
  bool _useSpecialChars = true;
  bool _useNumber = true;

  void updatePasswordConfig(int length, bool useSpecialChars) {
    setState(() {
      _passwordLength = length;
      _useSpecialChars = useSpecialChars;
    });
  }

  String generatePassword() {
    String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    if (_useSpecialChars) {
      chars += "!@#\$%^&*()[]{}:;<>,.?~";
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

    if (currentUser != null) {
      String userID = currentUser.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var secretKey = globals.secretKey;
      var aes = AesCrypt(key: secretKey, padding: PaddingAES.pkcs7);

      var cipherLogin = aes.gcm.encrypt(inp: _loginController.text, iv: userID);
      var cipherPassword =
          aes.gcm.encrypt(inp: _passwordController.text, iv: userID);
      var cipherServiceName =
          aes.gcm.encrypt(inp: _serviceNameController.text, iv: userID);
      var cipherNote = _noteController.text.isNotEmpty
          ? aes.gcm.encrypt(inp: _noteController.text, iv: userID)
          : "";

      await firestore
          .collection('users')
          .doc(userID)
          .collection('comptes')
          .add({
        'login': cipherLogin,
        'password': cipherPassword,
        'serviceName': cipherServiceName,
        'note': cipherNote,
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PasswordListScreen()),
        );
      }
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
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextField(
                      controller: _serviceNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom du service',
                      ),
                      maxLength: 16,
                    ),
                    TextField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        labelText: 'Identifiant',
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
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                              _passwordController.text = generatePassword();
                            });
                          },
                        )
                      ],
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
                          onPressed: () => _addAccountToFirestore(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text(
                            'AJOUTER',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordConfigScreen(
                      updatePasswordConfig: updatePasswordConfig,
                    ),
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
