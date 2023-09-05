import 'package:flutter/material.dart';

class ChangeMasterPasswordScreen extends StatefulWidget {
  @override
  _ChangeMasterPasswordScreenState createState() =>
      _ChangeMasterPasswordScreenState();
}

class _ChangeMasterPasswordScreenState
    extends State<ChangeMasterPasswordScreen> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Modifier le mot de passe principal'),
          titleTextStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _currentPasswordController,
              obscureText: _obscureCurrentPassword,
              decoration: InputDecoration(
                labelText: "Mot de passe actuel",
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: "Nouveau mot de passe",
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller: _confirmNewPasswordController,
              obscureText: _obscureConfirmNewPassword,
              decoration: InputDecoration(
                labelText: "Confirmez le nouveau mot de passe",
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmNewPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmNewPassword = !_obscureConfirmNewPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Vérifiez les mots de passe et mettez à jour le mot de passe principal
                final currentPassword = _currentPasswordController.text;
                final newPassword = _newPasswordController.text;
                final confirmNewPassword = _confirmNewPasswordController.text;

                if (currentPassword.isEmpty ||
                    newPassword.isEmpty ||
                    confirmNewPassword.isEmpty) {
                  // Affichez un message d'erreur si des champs sont vides
                  _showErrorSnackbar("Veuillez remplir tous les champs.");
                } else if (newPassword != confirmNewPassword) {
                  // Affichez un message d'erreur si les nouveaux mots de passe ne correspondent pas
                  _showErrorSnackbar(
                      "Les nouveaux mots de passe ne correspondent pas.");
                } else {
                  // Mettez à jour le mot de passe principal ici
                  // Assurez-vous de gérer les erreurs en cas d'échec de la mise à jour
                  // Si la mise à jour est réussie, affichez un message de succès
                  _showSuccessSnackbar("Mot de passe principal mis à jour.");
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: const Text('ENREGISTRER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
