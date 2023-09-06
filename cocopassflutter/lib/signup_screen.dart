import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

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

  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  bool isPasswordStrong = false;

  bool _accountExists = false;

  // Fonction de validation du formulaire
  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    final password = _masterPasswordController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final verifyPassword = _verifyPasswordController.text;

    // Vérification que les mots de passe correspondent
    if (password != verifyPassword) {
      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Les mots de passe ne correspondent pas"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await Auth()
          .registerWithEmailAndPassword(email, password, firstName, lastName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Création du compte réussie"),
          backgroundColor: Colors.green,
        ),
      );

      // Redirigez l'utilisateur vers la page HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Le compte existe déjà $e"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _accountExists = true;
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateState);
    _lastNameController.addListener(_updateState);
    _emailController.addListener(_updateState);
    _masterPasswordController.addListener(_updateState);
    _verifyPasswordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // Force le re-build du widget
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateState);
    _lastNameController.removeListener(_updateState);
    _emailController.removeListener(_updateState);
    _masterPasswordController.removeListener(_updateState);
    _verifyPasswordController.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte'),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _masterPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre mot de passe maître';
                  }
                  return null; // You can return your custom error message here
                },
                decoration: InputDecoration(
                  labelText: 'Mot de passe master',
                ),
              ),
              SizedBox(height: 10),
              FlutterPwValidator(
                controller: _masterPasswordController,
                minLength: 12,
                uppercaseCharCount: 1,
                lowercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                width: 400,
                height: 170,
                onSuccess: () {
                  setState(() {
                    isPasswordStrong = true;
                  });
                },
                onFail: () {
                  setState(() {
                    isPasswordStrong = false;
                  });
                },
              ),
              // Ajouter un message d'explication sur l'importance d'un mot de passe fort
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Conseils pour un mot de passe fort'),
                        content: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: const [
                              TextSpan(
                                text:
                                    '- Notre algorithme donne une idée de la force de votre mot de passe. Cependant, '
                                    'nous vous recommandons de suivre les conseils suivants pour créer votre mot de passe cocopass :\n'
                                    '- Évitez d\'utiliser des informations personnelles comme votre nom ou votre date de naissance.\n'
                                    '- Utiliser si possible, un mot de passe unique jamais utilisé ailleurs.\n',
                              ),
                              TextSpan(
                                text:
                                    '- Assurez-vous de choisir un mot de passe que vous pouvez retenir. Vous pouvez trouver un moyen mémotechnique pour vous aider. '
                                    'Par exemple avec les paroles d\'une chanson, une phrase, une citation, etc.\n',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Afficher les conseils'),
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
                onPressed: _firstNameController.text.isNotEmpty &&
                        _lastNameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _masterPasswordController.text.isNotEmpty &&
                        isPasswordStrong &&
                        _verifyPasswordController.text.isNotEmpty
                    ? () => handleSubmit()
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor:
                      isPasswordStrong ? Colors.deepPurple : Colors.grey,
                ),
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text("Créer un compte"),
              ),
              // Message de compte existant avec un lien vers la page de connexion
              if (_accountExists)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Le compte existe déjà. Cliquez ici pour vous connecter. ",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
