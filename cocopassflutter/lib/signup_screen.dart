import 'package:flutter/material.dart';
import 'auth.dart';
import 'home_screen.dart';

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

  final bool _isLogin = false;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

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
      if (_isLogin) {
        await Auth().signInWithEmailAndPassword(email, password);
        // Rediriger vers un écran spécifique après la connexion réussie
      } else {
        await Auth().registerWithEmailAndPassword(email, password, firstName, lastName);

        // Vérifier que le widget est toujours dans l'arbre des widgets
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      }
    } catch (e) {
      // TODO
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
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
              TextField(
                controller: _verifyPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Vérification de mot de passe',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => handleSubmit(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: Colors.deepPurple,
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
                    : Text(_isLogin ? 'Se connecter' : 'Créer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
