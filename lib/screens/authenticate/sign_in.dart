import 'package:bar_pub/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  FocusNode myFocusNode = FocusNode();

  //text field state
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        elevation: 0.0,
        title: Text('Login!'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Registrati'))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) {
                setState(() => email = val);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple[300]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.purple[300]
                          : Colors.black54),
                  icon: Icon(Icons.account_box, color: Colors.purple[300])),
              cursorColor: Colors.purple[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) {
                setState(() => password = val);
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple[300]),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.purple[300]
                          : Colors.black54),
                  icon: Icon(Icons.visibility_off, color: Colors.purple[300])),
              cursorColor: Colors.purple[300],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              print(email);
              print(password);
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
          /*ElevatedButton(
            onPressed: () {},
            child: Text('Registrati'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),*/
          ElevatedButton(
            onPressed: () => {},
            child: Text('Non ora!'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
        ],
      ),
    );
  }
}

/*Container(
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
      ),*/
