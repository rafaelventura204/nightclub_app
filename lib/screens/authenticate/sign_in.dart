import 'package:bar_pub/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        elevation: 0.0,
        title: Text('Registrati!'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
            child: Text('Entra senza registrazione'),
            onPressed: () async {
              dynamic result = await _auth.signInAnnon();
              if (result == null) {
                print("Errore accesso come anonimo!");
              } else {
                print("Benvenuto utente ANONIMO");
                print(result); //ID USER
              }
            }),
      ),
    );
  }
}
