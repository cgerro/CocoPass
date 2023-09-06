import 'package:cocopass/user_profile.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';
import 'list_password.dart';
import 'settings_screen.dart';
import 'package:provider/provider.dart';
import 'create_account.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final String username = "Alex";

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);

    // Supposons que vous ayez ces variables disponibles
    int weakPasswords =
        5; // Remplacez par le nombre réel de mots de passe faibles
    int mediumPasswords =
        3; // Remplacez par le nombre réel de mots de passe moyens
    int strongPasswords =
        2; // Remplacez par le nombre réel de mots de passe forts

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Bonjour, $username'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: SingleChildScrollView(
        // Ajout de SingleChildScrollView ici
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
            }
          }),
    );
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
}
