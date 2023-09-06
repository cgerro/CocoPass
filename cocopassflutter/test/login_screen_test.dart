// TODO: Vérifier que l'on peut créer un compte, se connecter, ajouter un compte mot de passe
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocopass/main.dart';

import 'package:cocopass/home_screen.dart';

void main() {
  testWidgets('Login Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MyApp()); // Remplacez MyApp() par le widget de votre application

    // Verify that the initial state shows the login screen.
    expect(find.text('Se connecter à CocoPass'), findsOneWidget);

    // Tap on the email and password text fields.
    await tester.tap(find.byType(TextFormField).at(0));
    await tester.pump();
    await tester.tap(find.byType(TextFormField).at(1));
    await tester.pump();

    // Enter some text into the email and password fields.
    await tester.enterText(
        find.byType(TextFormField).at(0), 'cipher@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'Cipher12345!');

    // Tap the "SE CONNECTER" button.
    await tester.tap(find.text('SE CONNECTER'));
    await tester.pump();

    // Verify that a CircularProgressIndicator appears when loading.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate a successful login by finding a widget on the next screen.
    await tester.pumpWidget(
        HomeScreen()); // Replace HomeScreen() with your actual next screen.

    // Verify that the login was successful.
    expect(find.text('Bonjour, Alex'), findsOneWidget);
  });
}
