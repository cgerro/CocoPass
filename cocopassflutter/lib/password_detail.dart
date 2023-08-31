import 'package:flutter/material.dart';

class AccountDetailPage extends StatefulWidget {
  final Map<String, dynamic> account;

  const AccountDetailPage({super.key, required this.account});

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  var obscureText = true;
  _AccountDetailPageState();

  Widget _detailBox(Widget child) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du compte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailBox(
              Row(
                children: [
                  CircleAvatar(
                    radius: 42,
                    child: Text(widget.account["serviceName"][0],
                      style: TextStyle(fontSize: 30),  // Rendre le texte en gras et augmenter la taille de la police
                  ), // First letter of the service name
                  ),
                  SizedBox(width: 16),
                  Text(widget.account["serviceName"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),  // Rendre le texte en gras et augmenter la taille de la police
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 42)),
            _detailBox(
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom d\'utilisateur',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),  // Rendre le texte en gras et augmenter la taille de la police
                      ),
                      Text(widget.account["login"]),
                    ],
                  ),
                ],
              ),
            ),
            _detailBox(
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mot de passe',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),  // Rendre le texte en gras et augmenter la taille de la police
                        ),
                        Text(obscureText ? '•' * widget.account["password"].length : widget.account["password"]),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }
                    ),
                  ]
              ),
            ),
            if (widget.account["note"] != null) // Show this only if the note field is specified
              _detailBox(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.note),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Note',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                        ),
                        Text(widget.account["note"]),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
