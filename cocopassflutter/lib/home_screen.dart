import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocopass/help_screen.dart';
import 'package:cocopass/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'bottom_navigation_bar.dart';
import 'list_password.dart';
import 'settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:zxcvbn/zxcvbn.dart';
import 'create_account.dart';
import 'globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final db = FirebaseFirestore.instance;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;
  late String userID;

  String username = "";
  late int weakPasswords;
  late int mediumPasswords;
  late int strongPasswords;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userID = currentUser!.uid;
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userID);
    final doc = await docRef.get();
    return doc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen();
        }

        username = snapshot.data?["firstName"] ?? "Inconnu";


        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .collection('comptes')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return loadingScreen();
            }
            isLoading = false; // Mettez à jour isLoading
            return _build(context, snapshot.data!.docs);
          },
        );
      },
    );
  }

  Widget loadingScreen() {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _build(BuildContext context, List<DocumentSnapshot> snapshots) {
    final userProfile = Provider.of<UserProfile>(context);
    final Zxcvbn zxcvbn = Zxcvbn();

    final secretKey = globals.secretKey;
    var aes = AesCrypt(key: secretKey, padding: PaddingAES.pkcs7);

    userProfile.fetchProfileImage();

    weakPasswords = 0;
    mediumPasswords = 0;
    strongPasswords = 0;

    for (var e in snapshots) {
      var data = e.data() as Map<String, dynamic>;
      if (data["password"] != null) {
        data["password"] = aes.gcm.decrypt(enc: data["password"], iv: userID);
        final result = zxcvbn.evaluate(data["password"]);
        switch (result.score) {
          case 0:
          case 1:
            ++weakPasswords;
            break;
          case 2:
          case 3:
            ++mediumPasswords;
            break;
          case 4:
            ++strongPasswords;
            break;
          default:
            break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Bonjour, $username'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(userProfile.userProfileImageUrl),
              ),
              const SizedBox(height: 10),
              Text(
                username,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Nouveau mot de passe',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Protégez maintenant votre vie privée en ajoutant un nouveau mot de passe',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 7),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountScreen(),
                          ),
                        );
                      },
                      child: const Text('Ajouter'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Complexité de vos mots de passe',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircle(
                              'Faible', Colors.red[400]!, weakPasswords),
                          _buildCircle(
                              'Moyen', Colors.orange[400]!, mediumPasswords),
                          _buildCircle(
                              'Fort', Colors.green[400]!, strongPasswords),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        PasswordListScreen(),
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
          }),
    );
  }
}

Widget _buildCircle(String label, Color color, int count) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
            child: Text('$count',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ))),
      ),
      SizedBox(height: 6),
      Text(label),
    ],
  );
}
