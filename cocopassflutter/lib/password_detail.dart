import 'package:flutter/material.dart';
import 'change_password_detail.dart';

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
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditAccountPage(account: widget.account),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailBox(
              Row(
                children: [
                  CircleAvatar(
                    radius: 42,
                    child: Text(
                      widget.account["serviceName"][0],
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    widget.account["serviceName"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 42),
            _detailBox(
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nom d\'utilisateur',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
                      Text(
                        'Mot de passe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        obscureText
                            ? '•' * widget.account["password"].length
                            : widget.account["password"],
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (widget.account["note"] != "")
              _detailBox(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.note),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.account["note"],
                            softWrap: true,
                          ),
                        ],
                      ),
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
