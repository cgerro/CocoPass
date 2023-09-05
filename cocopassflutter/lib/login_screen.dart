import 'package:flutter/material.dart';
import 'auth.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _loading = false;
  String _message = '';
  Color _messageColor = Colors.red;

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

  handleSubmit() async {
    if (!_loading) {
      setState(() => _loading = true);
      _clearMessage();

      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        await Auth().signInWithEmailAndPassword(email, password);
        _showMessage('Connexion réussie', true);

        // Vérifiez si le contexte est toujours valide (c'est-à-dire que le widget est toujours dans l'arbre)
        if (mounted) {
          // Redirigez vers la page CreateAccountScreen après une connexion réussie
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } catch (e) {
        _showMessage('Erreur lors de la connexion : $e', false);
      } finally {
        if (mounted) {
          setState(() => _loading = false);
        }
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
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer votre adresse e-mail';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureCurrentPassword,
              decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer votre mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 10),
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
