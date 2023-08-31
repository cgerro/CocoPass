import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final String username = "Alex";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Hello, $username'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user_icon.png'),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Container avec le texte et le bouton
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
                    'Nouveau mot de passe', // Titre du container
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Protégez maintenant votre vie privée en ajoutant en ajoutant un nouveau mot de passe',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Logique pour créer un nouveau mot de passe
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          // color: Colors.grey[850],
          BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Mots de passe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          )
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[200],
        /*
              onTap: (index) {
                if (index == 1) {
                  // Naviguer vers l'écran 'Liste des mots de passe'
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MotsDePasseScreen()));
                } else if (index == 2) {
                  // Naviguer vers l'écran 'Paramètres'
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParametreScreen()));
                }
                
              } */
      ),
    );
  }
}
