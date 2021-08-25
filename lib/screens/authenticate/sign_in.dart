import 'package:bar_pub/screens/authenticate/components/body.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}


/*class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  FocusNode myFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  GlobalPreferences gPref = GlobalPreferences();
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
        title: Text('Login'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person, color: Color(0XFFFFFFFF)),
              label: Text(
                'Registrati',
                style: TextStyle(color: Color(0XFFFFFFFF)),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Inserisci email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.7)),
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
                          icon: Icon(Icons.account_box,
                              color: Colors.purple[300])),
                      cursorColor: Colors.purple[300],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.7)),
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
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var checkAuth =
                    await _auth.signInWithEmailPassword(email, password);
                if (checkAuth == null) {
                  setState(
                      () => error = "Email non registrata oppure non corretta");
                } else {
                  gPref.addStringToSF(email);
                  //setState(() async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHome()));
                  //});
                }
              }
            },
            child: Text('Login'),
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
*/