//import 'package:bar_pub/registrazione.dart';
import 'package:flutter/material.dart';
import 'package:bar_pub/screens/home/home.dart';

void main() => runApp(MyLogin());

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Locali Intrattenimento',
        home: MyLoginPage(title: 'Login'),
        routes: {
          '/home': (context) => MyHome(),
          //'/registration': (context) => MyRegistration(),
        });
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
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
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyHome()));
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
          ),
          ElevatedButton(
            onPressed: () {
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyRegistration()));*/
            },
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
