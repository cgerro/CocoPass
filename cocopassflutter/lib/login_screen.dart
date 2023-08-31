import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String _message = '';

  void _showMessage(String message, bool isSuccess) {
    setState(() {
      _message = message;
      _messageColor = isSuccess ? Colors.green : Colors.red;
    });
  }

  void _clearMessage() {
    setState(() {
      _message = '';
    });
  }

  Color _messageColor = Colors.red;

  handleSubmit() async {
    if (!_loading) {
      setState(() => _loading = true);
      _clearMessage();

      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        await Auth().signInWithEmailAndPassword(email, password);
        _showMessage('Connexion réussie', true);
      } catch (e) {
        _showMessage('Erreur lors de la connexion : $e', false);
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Se connecter à CocoPass'),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleSubmit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              child: _loading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : Text('SE CONNECTER', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Text(
              _message,
              style: TextStyle(color: _messageColor),
            ),
          ],
        ),
      ),
    );
  }
}
