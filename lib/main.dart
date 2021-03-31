import 'package:bar_pub/models/user.dart';
import 'package:bar_pub/screens/wrapper.dart';
import 'package:bar_pub/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*Questo stream è in ascolto, nel caso l'utente sia loggato e nel caso l'utente non sia loggato*/
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Locali Intrattenimento',

      home: Wrapper(),
      /*home: MyAppPage(title: 'Home'),
      routes: {
          '/home': (context) => MyHome(),
          '/registration': (context) => MyRegistration(),
        }*/
    );
  }
}*/

/*class MyAppPage extends StatefulWidget {
  MyAppPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _selectIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MyHome(),
    MySearch(),
    MyProfile(),
  ];

  void myOnTap(int _index) {
    setState(() {
      _selectIndex = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.purple[300],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectIndex,
        onTap: myOnTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cerca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}*/
