import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String selectedIcon =
      'assets/user_icons/user_icon1.png'; // L'icône par défaut

  final List<String> userIcons = [
    'assets/user_icons/user_icon1.png',
    'assets/user_icons/user_icon2.png',
    'assets/user_icons/user_icon3.png',
    'assets/user_icons/user_icon4.png',
    'assets/user_icons/user_icon5.png',
    'assets/user_icons/user_icon6.png',
    'assets/user_icons/user_icon7.png',
    'assets/user_icons/user_icon8.png',
    'assets/user_icons/user_icon9.png',
    'assets/user_icons/user_icon10.png',
    'assets/user_icons/user_icon11.png',
    'assets/user_icons/user_icon12.png',
    'assets/user_icons/user_icon13.png',
    'assets/user_icons/user_icon14.png',
    // Ajoutez ici plus d'icônes utilisateur si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Modifier le profil'),
          titleTextStyle:
              const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width:
                  100, // Ajustez la taille de l'icône utilisateur selon vos besoins
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(selectedIcon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Choisissez une icône utilisateur :'),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width, // Largeur de l'écran
              height:
                  100, // Ajustez la hauteur de la liste horizontale selon vos besoins
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userIcons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = userIcons[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width:
                            60, // Ajustez la taille des icônes utilisateur selon vos besoins
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(userIcons[index]),
                            fit: BoxFit.cover,
                          ),
                          border: selectedIcon == userIcons[index]
                              ? Border.all(
                                  color: Colors.deepPurple,
                                  width: 2.0,
                                )
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour sauvegarder la nouvelle icône utilisateur
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Paramètres enregistrés avec succès.'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: const Text('ENREGISTRER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
