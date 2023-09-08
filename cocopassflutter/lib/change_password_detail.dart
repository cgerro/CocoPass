import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'list_password.dart';
import 'globals.dart' as globals;

class EditAccountPage extends StatefulWidget {
  final Map<String, dynamic> account;

  const EditAccountPage({Key? key, required this.account}) : super(key: key);

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _serviceNameController;
  late TextEditingController _noteController;

  var _obscureText = true;

  User? currentUser;
  late String userID;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController(text: widget.account['login']);
    _passwordController =
        TextEditingController(text: widget.account['password']);
    _serviceNameController =
        TextEditingController(text: widget.account['serviceName']);
    _noteController = TextEditingController(text: widget.account['note']);

    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userID = currentUser!.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le compte'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
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
                    labelText: "Identifiant",
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // delete database
                        deleteFirestoreAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.red,
                      ),
                      child: Text('SUPPRIMER',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Mise à jour sur firestore
                        updateFirestoreAccount(
                          _loginController.text,
                          _passwordController.text,
                          _serviceNameController.text,
                          _noteController.text,
                        ).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Mise à jour du compte réussie"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Si la mise à jour est réussie, on revient sur PasswordListScreen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordListScreen()));
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Échec de la mise à jour du compte : $error"),
                            backgroundColor: Colors.red,
                          ));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child:
                          Text('EDITER', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateFirestoreAccount(
      login, password, serviceName, note) async {

    DocumentReference accountRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('comptes')
        .doc(widget.account["accountID"]);

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

    return await accountRef.update({
      'login': cipherLogin,
      'password': cipherPassword,
      'serviceName': cipherServiceName,
      'note': cipherNote,
    });
  }

  void deleteFirestoreAccount() async {
    // Notez le mot-clé async
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer le compte'),
          content: Text('Êtes-vous sûr de vouloir supprimer ce compte ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                DocumentReference accountRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(userID)
                    .collection('comptes')
                    .doc(widget.account["accountID"]);

                try {
                  await accountRef.delete();

                  if (!context.mounted) return;

                  Navigator.of(context).pop();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordListScreen()),
                  );
                } catch (error) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
