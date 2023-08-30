import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_name_generator/random_name_generator.dart';

class Database extends StatefulWidget {
  final utilisateur;

  const Database({super.key, required this.utilisateur});

  String getUtilisateur() => utilisateur;

  @override
  State<Database> createState() => _DatabaseState(utilisateur);
}

class _DatabaseState extends State<Database> {
  late final utilisateur;
  final db = FirebaseFirestore.instance;


  _DatabaseState(String utilisateur) {
    this.utilisateur = utilisateur;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle:true, title: Text('Mots de passe')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Database(utilisateur: utilisateur), // Creation mdp
              ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // à ajouter dans la page création de compte
// add(user) {
//     var randomNames = RandomNames(Zone.switzerland);
//     var i = randomNames.name();
//     final userToAdd = <String, dynamic>{
//       "username": "username " + i,
//       "password": "password " + i
//     };
//     db.collection("Users/" + user + "/info").doc("site " + i).set(userToAdd);
//   }


  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users/' + utilisateur + '/info').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.username),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.username),
          trailing: Text(record.password),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Record {
  final String username;
  final String password;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['username'] != null),
        username = map['username'],
        password = map['password'];


  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Record<$username$password>";
}