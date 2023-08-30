import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Se connecter à CocoPass'),
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // String email = _emailController.text;
                // String password = _passwordController.text;
                // Vous pouvez appeler une fonction de validation/auth

                /*
                if (ValidationUtils.isValidEmail(email)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où l'email n'est pas valide
                }

                if (ValidationUtils.isValidPassword(password)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où le mot de passe n'est pas valide
                }
                */
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child:
                  Text('SE CONNECTER', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
