import 'package:cocopass/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'profil_edit_screen.dart';
import 'bottom_navigation_bar.dart';
import 'clipboard_clear_screen.dart';
import 'home_screen.dart';
import 'list_password.dart';
import 'change_master_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Paramètres'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          // padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              color: Colors.grey[850],
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Effacer presse-papier',
                        style: TextStyle(fontSize: 16)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Naviguer vers l'écran de modification du profil
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ClipboardClearScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              color: Colors.grey[850],
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child:
                        Text('Modifier profil', style: TextStyle(fontSize: 16)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Naviguer vers l'écran de modification du profil
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfileEditScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              color: Colors.grey[850],
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('Modifier mot de passe master',
                        style: TextStyle(fontSize: 16)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Naviguer vers l'écran de modification du profil
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ChangeMasterPasswordScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                await FirebaseAuth.instance.signOut();
                Navigator.of(currentContext).pushReplacement(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: const Text('SE DÉCONNECTER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ]),
      bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ));
            } else if (index == 1) {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        PasswordListScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ));
            }
          }),
    );
  }
}
