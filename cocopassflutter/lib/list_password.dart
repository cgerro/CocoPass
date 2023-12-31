import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocopass/help_screen.dart';
import 'package:cocopass/password_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bottom_navigation_bar.dart';
import 'create_account.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'clipboard.dart';
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
  String searchString = "";
  late String userID;

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
        return Colors.red[400]!;
      case 2:
      case 3:
        return Colors.orange[400]!;
      case 4:
        return Colors.green[400]!;
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
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.transparent,
            ),
          );
        }
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {
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
        data["serviceName"] =
            aes.gcm.decrypt(enc: data["serviceName"], iv: userID);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
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
                if (accounts[index]["serviceName"]
                    .toLowerCase()
                    .contains(searchString)) {
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text(accounts[index]["serviceName"]
                            .substring(0, 1)
                            .toUpperCase()),
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
                              color: getPasswordStrengthColor(
                                  accounts[index]["password"]),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                              width:
                                  8),
                          IconButton(
                            icon: Icon(Icons.copy),
                            onPressed: () {
                              ClipboardManager.copyToClipboard(
                                  accounts[index]["password"]);
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
                } else {
                  return SizedBox.shrink();
                }
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
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      HomeScreen(),
                  transitionDuration: Duration(seconds: 0),
                ));
          } else if (index == 2) {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SettingScreen(),
                  transitionDuration: Duration(seconds: 0),
                ));
          } else if (index == 3) {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      HelpScreen(),
                  transitionDuration: Duration(seconds: 0),
                ));
          }
        }
      ),
    );
  }
}
