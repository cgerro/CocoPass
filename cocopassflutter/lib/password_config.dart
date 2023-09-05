import 'package:flutter/material.dart';

class PasswordConfigScreen extends StatefulWidget {
  final Function updatePasswordConfig;

  const PasswordConfigScreen({required this.updatePasswordConfig, Key? key})
      : super(key: key);

  @override
  _PasswordConfigScreenState createState() => _PasswordConfigScreenState();
}

class _PasswordConfigScreenState extends State<PasswordConfigScreen> {
  double _length = 16.0;
  bool _useLowercase = true;
  bool _useUppercase = true;
  bool _useNumber = true;
  bool _useSpecialChars = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramétrer le mot de passe"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100.0, bottom: 16.0),
                child: Text("Longueur du mot de passe: ${_length.toInt()}"),
              ),
              Slider(
                value: _length,
                min: 12,
                max: 32,
                onChanged: (value) {
                  setState(() {
                    _length = value;
                  });
                },
              ),
              SizedBox(height: 16.0), // Espace ajouté
              CheckboxListTile(
                title: Text("Utiliser des minuscules"),
                value: _useLowercase,
                onChanged: (newValue) {
                  setState(() {
                    _useLowercase = newValue!;
                  });
                },
              ),
              SizedBox(height: 16.0), // Espace ajouté
              CheckboxListTile(
                title: Text("Utiliser des majuscules"),
                value: _useUppercase,
                onChanged: (newValue) {
                  setState(() {
                    _useUppercase = newValue!;
                  });
                },
              ),
              SizedBox(height: 16.0), // Espace ajouté
              CheckboxListTile(
                title: Text("Utiliser des chiffres"),
                value: _useNumber,
                onChanged: (newValue) {
                  setState(() {
                    _useNumber = newValue!;
                  });
                },
              ),
              SizedBox(height: 16.0), // Espace ajouté
              CheckboxListTile(
                title: Text("Utiliser des caractères spéciaux"),
                value: _useSpecialChars,
                onChanged: (newValue) {
                  setState(() {
                    _useSpecialChars = newValue!;
                  });
                },
              ),
              SizedBox(height: 60.0), // Espace ajouté
              Row(
                children: [
                  Expanded(
                    child:
                    SizedBox(), // Cette partie pousse le bouton vers la droite
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.updatePasswordConfig(
                        _length.toInt(),
                        _useLowercase,
                        _useUppercase,
                        _useNumber,
                        _useSpecialChars,
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Mettre à jour"),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
