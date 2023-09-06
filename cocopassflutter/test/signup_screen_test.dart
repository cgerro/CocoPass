import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocopass/main.dart'; // Remplacez par le chemin réel de votre application
import 'package:cocopass/home_screen.dart'; // Remplacez par le chemin réel de votre écran de création de compte

void main() {
  testWidgets('Signup Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MyApp()); // Remplacez MyApp() par le widget de votre application

    // Verify that the initial state shows the signup screen.
    expect(find.text('Créer un compte'), findsOneWidget);

    // Tap on the text fields and enter some text.
    await tester.tap(find.byType(TextField).at(0));
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(0), 'John');
    await tester.tap(find.byType(TextField).at(1));
    await tester.pump();
    await tester.enterText(find.byType(TextField).at(1), 'Doe');
    await tester.tap(find.byType(TextFormField).at(0));
    await tester.pump();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.tap(find.byType(TextFormField).at(1));
    await tester.pump();
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(TextFormField).at(2));
    await tester.pump();
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');
    await tester.pump();

    // Tap the "Créer un compte" button.
    await tester.tap(find.text('Créer un compte'));
    await tester.pump();

    // Verify that a CircularProgressIndicator appears when loading.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate a successful signup by finding a widget on the next screen.
    await tester.pumpWidget(
        HomeScreen()); // Replace HomeScreen() with your actual next screen.

    // Verify that the signup was successful.
    expect(find.text('Bonjour, John'), findsOneWidget);
  });
}
