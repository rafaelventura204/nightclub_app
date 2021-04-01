import 'package:bar_pub/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  FocusNode myFocusNode = FocusNode();
  /*Associo ai dati della form una global key univoca, in modo da avere utenti univoci*/
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        elevation: 0.0,
        title: Text('Registrati!'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Login'))
        ],
      ),
      body: Column(
        key: _formKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Inserisci email' : null,
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
            child: TextFormField(
              validator: (val) => val.length < 6
                  ? 'Inserisci password con più di 6 caratteri'
                  : null,
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
              //controlla se ciò che + dentro al form è valido o no
              if (_formKey.currentState.validate()) {
                print(email);
                print(password);
              }
            },
            child: Text('Registrati'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Registrati'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
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
