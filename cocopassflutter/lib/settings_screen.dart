import 'package:cocopass/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'master_password_edit_screen.dart';
import 'profil_edit_screen.dart';
import 'bottom_navigation_bar.dart';
import 'clipboard_clear_screen.dart';
import 'home_screen.dart';
import 'list_password.dart';
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
                        return ProfilEditScreen();
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
                        return MasterPasswordEditScreen();
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
      bottomNavigationBar:
          // color: Colors.grey[850],
          MyBottomNavigationBar(
              currentIndex: 2,
              onTap: (index) {
                if (index == 0) {
                  // Naviguer vers l'écran 'Accueil'
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else if (index == 1) {
                  // Naviguer vers l'écran 'Liste des mots de passe
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordListScreen()));
                }
              }),
    );
  }
}
