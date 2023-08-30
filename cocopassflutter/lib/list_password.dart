import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account {
  final String serviceName;
  final String email;
  final String password;

  Account(this.serviceName, this.email, this.password);
}


class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({Key? key}) : super(key: key);

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}


class _PasswordListScreenState extends State<PasswordListScreen> {
  static const String utilisateur = "gens1";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users/$utilisateur/info').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {

    var accounts = [];
    for (var e in snapshots) {
      accounts.add(e.data() as Map<String, dynamic>);
    }

    return Scaffold(
      appBar: AppBar(
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
              itemCount: snapshots.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    // Ici, vous pouvez ajouter l'image du service
                    child: Text(accounts[index]["serviceName"].substring(0, 1)),
                  ),
                  title: Text(accounts[index]["serviceName"]),
                  subtitle: Text(accounts[index]["email"]),
                  trailing: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      // Logique pour copier le mot de passe
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'Ã©cran CreateAccountScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PasswordListScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}