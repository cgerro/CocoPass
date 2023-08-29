import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/cocopass_logo.png', // Chemin vers l'image
              width: 308,
              height: 133,
            ),
          ),
          SizedBox(height: 60.0), // Espacement entre le logo et les boutons

          SizedBox(
            width: 300,
            // height: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: Text('CONNEXION', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(height: 10.0),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: Colors.deepPurple),
              child: Text('CRÉER UN COMPTE',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
