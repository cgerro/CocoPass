import 'package:flutter/material.dart';

class PasswordConfigScreen extends StatefulWidget {
  final Function updatePasswordConfig;

  const PasswordConfigScreen({required this.updatePasswordConfig, Key? key})
      : super(key: key);

  @override
  State<PasswordConfigScreen> createState() => _PasswordConfigScreenState();
}

class _PasswordConfigScreenState extends State<PasswordConfigScreen> {
  double _length = 16.0;
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
