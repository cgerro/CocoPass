import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocopass/main.dart';
import 'package:cocopass/home_screen.dart';
import 'package:cocopass/signup_screen.dart';
import 'package:cocopass/login_screen.dart';
import 'package:cocopass/clipboard_clear_screen.dart';
import 'package:cocopass/create_account.dart';
import 'package:cocopass/bottom_navigation_bar.dart';
import 'package:cocopass/password_config.dart';
import 'package:cocopass/password_detail.dart';
import 'package:cocopass/list_password.dart';
import 'package:cocopass/settings_screen.dart';
import 'package:cocopass/profil_edit_screen.dart';
import 'package:cocopass/welcome_screen.dart';

void main() {
  testWidgets('Test du widget SignupScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupScreen()));

    expect(find.text('Créer un compte'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'example@email.com');
    expect(find.text('example@email.com'), findsOneWidget);
  });

  // testWidgets('Test du widget HomeScreen', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

  //   expect(find.text('Bonjour, Alex'), findsOneWidget);
//});

  testWidgets('Test du widget LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Se connecter à CocoPass'), findsOneWidget);

    // Saisie e-mail"
    await tester.enterText(find.byType(TextFormField), 'example@email.com');
  });

  testWidgets('Test du widget MyApp (main.dart)', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyApp()));

    expect(find.text('Flutter Demo'), findsOneWidget);
  });

  testWidgets('Test du widget MyBottomNavigationBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {},
          ),
        ),
      ),
    );

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Mots de passe'), findsOneWidget);
    expect(find.text('Paramètres'), findsOneWidget);
  });

  testWidgets('Test du widget ClipboardClearScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ClipboardClearScreen()));

    expect(find.text('Effacer le presse-papiers'), findsOneWidget);
    expect(find.text('Sélectionnez le délai pour effacer le presse-papiers :'),
        findsOneWidget);
  });

  testWidgets('Test du widget CreateAccount', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateAccountScreen()));

    // Tests pour les champs des formulaires
    await tester.enterText(find.byType(TextField).at(0), 'John'); // Prénom
    await tester.enterText(find.byType(TextField).at(1), 'Doe'); // Nom
  });

  testWidgets('Test du widget PasswordListScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordListScreen(),
      ),
    );

    await tester.enterText(find.byType(TextField), 'example');
    await tester.pumpAndSettle();

    expect(find.text('Example Service'), findsOneWidget);
  });

  testWidgets('Test du widget PasswordConfigScreen',
      (WidgetTester tester) async {
    // ignore: unused_local_variable
    bool passwordConfigUpdated = false;

    await tester.pumpWidget(
      MaterialApp(
        home: PasswordConfigScreen(
          updatePasswordConfig: () {
            passwordConfigUpdated = true;
          },
        ),
      ),
    );

    // Interactions utilisateurs
    await tester.drag(find.byType(Slider), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Longueur du mot de passe: 16'), findsOneWidget);
  });

  testWidgets('Test du widget AccountDetailPage', (WidgetTester tester) async {
    final exampleAccount = {
      "serviceName": "Example Service",
      "login": "exampleuser",
      "password": "examplepassword",
      "note": "This is an example note.",
    };

    await tester.pumpWidget(
      MaterialApp(
        home: AccountDetailPage(account: exampleAccount),
      ),
    );

    expect(find.text('Example Service'), findsOneWidget);
    expect(find.text('exampleuser'), findsOneWidget);
    expect(find.text('•••••••••••••••••'), findsOneWidget);
    expect(find.text('This is an example note.'), findsOneWidget);
  });

  testWidgets('Test du widget ProfileEditScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileEditScreen(),
      ),
    );

    await tester.tap(find
        .byType(GestureDetector)
        .at(1)); // Sélectionnez la deuxième icône utilisateur
    await tester.pumpAndSettle();
    expect(find.byType(Container).first, findsOneWidget);

    await tester.tap(find.text('ENREGISTRER'));
    await tester.pumpAndSettle();
    expect(find.text('Paramètres enregistrés avec succès.'), findsOneWidget);
  });

  testWidgets('Test du widget SettingScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingScreen(),
      ),
    );

    // Interactions utilisateurs
    await tester.tap(find.text('Effacer presse-papier'));
    await tester.pumpAndSettle();
    expect(find.byType(ClipboardClearScreen), findsOneWidget);

    await tester.tap(find.text('Modifier profil'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileEditScreen), findsOneWidget);

    await tester.tap(find.text('Modifier mot de passe master'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('SE DÉCONNECTER'));
    await tester.pumpAndSettle();
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('Test du widget WelcomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeScreen(),
      ),
    );

    // Interactions utilisateurs (bouton connexion, bouton création de compte)
    await tester.tap(find.text('CONNEXION'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.text('CRÉER UN COMPTE'));
    await tester.pumpAndSettle();
    expect(find.byType(SignupScreen), findsOneWidget);
  });
}
