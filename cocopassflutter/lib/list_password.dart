import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocopass/password_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bottom_navigation_bar.dart';
import 'create_account.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({Key? key}) : super(key: key);

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {

  User? currentUser;
  String? userID;  // initialisez userID comme une chaîne nullable

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userID = currentUser!.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot> (
      stream: FirebaseFirestore.instance.collection('users').doc(userID).collection('comptes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {
    var accounts = [];
    for (var e in snapshots) {
      var data = e.data() as Map<String, dynamic>;
      data["accountID"] = e.id;
      if (data["serviceName"] != null &&
          data["login"] != null &&
          data["password"] != null) accounts.add(data);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Mots de passe'),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Recherche',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          // Liste des comptes
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(accounts[index]["serviceName"].substring(0, 1)),
                  ),
                  title: Text(accounts[index]["serviceName"]),
                  subtitle: Text(accounts[index]["login"]),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      _copyToClipboard(accounts[index]["password"]);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountDetailPage(account: accounts[index])),
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAccountScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,

          currentIndex: 1,
          onTap: (index) {
            if (index == 1) {
              // Naviguer vers l'écran 'Liste des mots de passe'
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordListScreen()));
            // } else if (index == 2) {
            //   // Naviguer vers l'écran 'Paramètres'
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ParametreScreen()));
            }
          }),
    );
  }
}

void _copyToClipboard(password) {
  Clipboard.setData(ClipboardData(text: password));

  // TODO fichier de paramètre
  Future.delayed(Duration(seconds: 10), () {
    Clipboard.setData(ClipboardData(text: ""));
  });
}