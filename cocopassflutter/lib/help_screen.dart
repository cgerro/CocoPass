import 'package:cocopass/bottom_navigation_bar.dart';
import 'package:cocopass/home_screen.dart';
import 'package:cocopass/list_password.dart';
import 'package:cocopass/settings_screen.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Aide et Conseils'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Bienvenue dans l\'écran d\'aide',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Fonctionnalités de l\'application :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Génération de Mots de Passe : Cette application vous permet de générer des mots de passe forts et sécurisés pour vos comptes en ligne.',
            ),
            Text(
              '2. Stockage de Mots de Passe : Vous pouvez enregistrer et gérer vos mots de passe générés en toute sécurité.',
            ),
            Text(
              '3. Sécurité : Votre sécurité est notre priorité. Les mots de passe générés sont forts et chiffrés.',
            ),
            SizedBox(height: 16.0),
            Text(
              'L\'importance de la sécurité des mots de passe :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Un mot de passe fort est essentiel pour protéger vos comptes en ligne contre les menaces potentielles.',
            ),
            Text(
              'Un bon mot de passe doit contenir une combinaison de lettres majuscules et minuscules, de chiffres et de caractères spéciaux.',
            ),
            Text(
              'Évitez d\'utiliser des informations personnelles, telles que votre nom ou votre date de naissance, dans vos mots de passe.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Les caractères spéciaux dans les mots de passe :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Bien que vous puissiez être libre de modifier les caractères spéciaux dans les mots de passe générés, il est recommandé de ne pas le faire sauf si le site ou l\'application pour laquelle vous créez un compte n\'accepte pas certains caractères spéciaux.',
            ),
            Text(
              'La plupart des sites acceptent désormais une grande variété de caractères spéciaux, il est donc préférable de laisser les caractères spéciaux tels quels dans les mots de passe générés pour une sécurité maximale.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Nous espérons que vous utiliserez cette application pour renforcer la sécurité de vos comptes en ligne. Si vous avez des questions ou des préoccupations, n\'hésitez pas à nous contacter.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: 3,
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
}
