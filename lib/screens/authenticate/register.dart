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
  String error = "";
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
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
                        icon:
                            Icon(Icons.account_box, color: Colors.purple[300])),
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
                        icon: Icon(Icons.visibility_off,
                            color: Colors.purple[300])),
                    cursorColor: Colors.purple[300],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                //print(email);
                //print(password);
                dynamic result =
                    await _auth.registerWithEmailPassword(email, password);
                if (result == null) {
                  setState(
                      () => error = "Email non valida, inserire nuovamente");
                }
              }
            },
            child: Text('Registrati'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
          SizedBox(height: 12.0),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
