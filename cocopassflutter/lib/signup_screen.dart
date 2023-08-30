import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _masterPasswordController =
      TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Créer un compte'),
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Prénom',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            TextField(
              controller: _masterPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe master',
              ),
            ),
            TextField(
              controller: _verifyPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Vérification de mot de passe',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique pour le bouton de création de compte
                /*
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String masterPassword = _masterPasswordController.text;
                String verifyPassword = _verifyPasswordController.text;
                // Ajoutez ici la logique de validation et de création de compte

                if (ValidationUtils.isValidFirstName(firstName)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où le firstName n'est pas valide
                }

                if (ValidationUtils.isValidLastName(lastName)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où le lastName n'est pas valide
                }

                if (ValidationUtils.isValidEmail(email)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où l'email n'est pas valide
                }

                if (ValidationUtils.isValidPassword(masterPassword)) {
                  // Logique de validation ici
                } else {
                  // Gérer le cas où l'email n'est pas valide
                }

                if (masterPassword != verifyPassword) {
                  // Gérer le cas où les mots de passe master ne sont pas pareil
                }
                */
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: Text('CRÉER UN COMPTE',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
