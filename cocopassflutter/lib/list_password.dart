import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocopass/password_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bottom_navigation_bar.dart';
import 'create_account.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'package:zxcvbn/zxcvbn.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'globals.dart' as globals;

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({Key? key}) : super(key: key);

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  User? currentUser;
  late String userID; // initialisez userID comme une chaîne nullable

  final Zxcvbn zxcvbn = Zxcvbn();

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userID = currentUser!.uid;
    }
  }

  Color getPasswordStrengthColor(String password) {
    final result = zxcvbn.evaluate(password);
    switch (result.score) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
      case 3:
        return Colors.orange;
      case 4:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('comptes')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return FutureBuilder<Widget>(
          future: _buildList(context, snapshot.data!.docs),
          builder: (context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return snapshot.data!;
          },
        );
      },
    );
  }

  Future<Widget> _buildList(BuildContext context, List<DocumentSnapshot> snapshots) async {

    final secretKey = globals.secretKey;
    var aes = AesCrypt(key: secretKey, padding: PaddingAES.pkcs7);

    var accounts = [];
    for (var e in snapshots) {
      var data = e.data() as Map<String, dynamic>;
      data["accountID"] = e.id;
      if (data["serviceName"] != null &&
        data["login"] != null &&
        data["password"] != null) {

        data["login"] = aes.gcm.decrypt(enc: data["login"], iv: userID);
        data["serviceName"] = aes.gcm.decrypt(enc: data["serviceName"], iv: userID);
        data["password"] = aes.gcm.decrypt(enc: data["password"], iv: userID);

        if (data["note"] != "") {
          data["note"] = aes.gcm.decrypt(enc: data["note"], iv: userID);
        }

        accounts.add(data);
      }
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Mots de passe'),
          titleTextStyle:
          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      child: Text(accounts[index]["serviceName"].substring(0, 1).toUpperCase()),
                    ),
                    title: Text(accounts[index]["serviceName"]),
                    subtitle: Text(accounts[index]["login"]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: getPasswordStrengthColor(accounts[index]["password"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8), // Espacement entre le cercle et l'icône
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            _copyToClipboard(accounts[index]["password"]);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AccountDetailPage(account: accounts[index])),
                      );
                    });
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            // Navigate to the HomeScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 2) {
            // Navigate to the 'SettingsScreen'
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingScreen()),
            );
          }
        },
      ),
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
