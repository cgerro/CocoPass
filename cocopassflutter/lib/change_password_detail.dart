import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'list_password.dart';

class EditAccountPage extends StatefulWidget {
  final Map<String, dynamic> account;

  const EditAccountPage({Key? key, required this.account}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late TextEditingController _serviceNameController;
  late TextEditingController _noteController;

  var _obscureText = true;

  User? currentUser;
  String? userID; // initialisez userID comme une chaîne nullable

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
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: "Login",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // delete database
                        deleteFirestoreAccount();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordListScreen()));
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
                        // Assuming you have a function to update Firestore
                        updateFirestoreAccount(
                          _loginController.text,
                          _passwordController.text,
                          _serviceNameController.text,
                          _noteController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Colors.blue,
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

  void updateFirestoreAccount(login, password, serviceName, note) {
    // Ici, je suppose que vous avez une manière d'identifier de manière unique chaque compte dans Firestore.
    // Cela pourrait être un ID généré par Firestore, ou quelque chose que vous définissez.
    // Remplacez 'accountID' par la manière dont vous identifiez le compte à mettre à jour.

    // Obtenez la référence au document que vous souhaitez mettre à jour
    DocumentReference accountRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('comptes')
        .doc(widget.account["accountID"]);

    // Mettez à jour le document avec les nouvelles valeurs
    accountRef.update({
      'login': login,
      'password': password,
      'serviceName': serviceName,
      'note': note,
    }).then((_) {
      print("Document successfully updated!");
      // Vous pouvez également naviguer vers une autre page ici, si vous le souhaitez
    }).catchError((error) {
      print("Failed to update document: $error");
    });
  }

  void deleteFirestoreAccount() {
    DocumentReference accountRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('comptes')
        .doc(widget.account["accountID"]);

    accountRef.delete().then((_) {
      print("Document successfully deleted!");
      // Vous pouvez également naviguer vers une autre page ici, si vous le souhaitez
    }).catchError((error) {
      print("Failed to delete document: $error");
    });
  }
}
