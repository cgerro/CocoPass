import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cocopass/main.dart'; // Importez le fichier main.dart
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

    // Ajout de tests pour les champs de formulaire, par exemple :
    // Saisie dans le champ de texte "Email"
    await tester.enterText(find.byType(TextFormField), 'example@email.com');
    expect(find.text('example@email.com'), findsOneWidget);

    // Ajoutez d'autres tests au besoin
  });

  testWidgets('Test du widget HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Bonjour, Alex'), findsOneWidget);

    // Ajoutez des tests pour d'autres éléments de la page HomeScreen au besoin
  });

  testWidgets('Test du widget LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Se connecter à CocoPass'), findsOneWidget);

    // Testez la saisie dans le champ de texte "Email"
    await tester.enterText(find.byType(TextFormField), 'example@email.com');

    // Ajoutez des tests pour d'autres interactions utilisateur au besoin
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

    // Ajoutez des tests pour d'autres interactions utilisateur au besoin
  });

  testWidgets('Test du widget CreateAccount', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateAccountScreen()));

    // Ajoutez des tests pour les champs de formulaire, par exemple :
    await tester.enterText(find.byType(TextField).at(0), 'John'); // Prénom
    await tester.enterText(find.byType(TextField).at(1), 'Doe'); // Nom

    // Ajoutez d'autres tests au besoin
  });

  testWidgets('Test du widget PasswordListScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordListScreen(),
      ),
    );

    // Testez les interactions utilisateur, par exemple, la recherche, le clic sur un élément de liste, etc.
    // Par exemple, pour tester la recherche :
    await tester.enterText(find.byType(TextField), 'example');
    await tester.pumpAndSettle();

    expect(find.text('Example Service'), findsOneWidget);

    // Ajoutez d'autres tests au besoin
  });

  testWidgets('Test du widget PasswordConfigScreen',
      (WidgetTester tester) async {
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

    // Testez les interactions utilisateur, par exemple, déplacer le curseur de longueur, cocher/décocher les cases, etc.
    // Par exemple, tester le curseur de longueur :
    await tester.drag(find.byType(Slider), Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Longueur du mot de passe: 16'), findsOneWidget);

    // Ajoutez d'autres tests au besoin
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

    // Testez les éléments de la page, par exemple, l'affichage du nom de service, du nom d'utilisateur, du mot de passe, etc.
    expect(find.text('Example Service'), findsOneWidget);
    expect(find.text('exampleuser'), findsOneWidget);
    expect(find.text('•••••••••••••••••'), findsOneWidget);
    expect(find.text('This is an example note.'), findsOneWidget);

    // Ajoutez d'autres tests au besoin
  });

  testWidgets('Test du widget ProfileEditScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProfileEditScreen(),
      ),
    );

    // Testez les interactions utilisateur, par exemple, la sélection d'une icône utilisateur, le clic sur le bouton "ENREGISTRER", etc.
    await tester.tap(find
        .byType(GestureDetector)
        .at(1)); // Sélectionnez la deuxième icône utilisateur
    await tester.pumpAndSettle();
    expect(find.byType(Container).first, findsOneWidget);

    await tester.tap(find.text('ENREGISTRER'));
    await tester.pumpAndSettle();
    expect(find.text('Paramètres enregistrés avec succès.'), findsOneWidget);

    // Ajoutez d'autres tests au besoin
  });

  testWidgets('Test du widget SettingScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingScreen(),
      ),
    );

    // Testez les interactions utilisateur, par exemple, le clic sur les éléments du menu, le clic sur le bouton de déconnexion, etc.
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

    // Testez les interactions utilisateur, par exemple, le clic sur les boutons "CONNEXION" et "CRÉER UN COMPTE".
    await tester.tap(find.text('CONNEXION'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.text('CRÉER UN COMPTE'));
    await tester.pumpAndSettle();
    expect(find.byType(SignupScreen), findsOneWidget);
  });
}
