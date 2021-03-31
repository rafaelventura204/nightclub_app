import 'package:bar_pub/screens/home/home.dart';
import 'package:bar_pub/profilo.dart';
import 'package:bar_pub/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigationPage(),
    );
  }
}

class MyNavigationPage extends StatefulWidget {
  @override
  _MyNavigationPageState createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  int _selectIndex = 0;

  final List<Widget> _widgetsPage = [
    Text('CIAO'),
    MyNavigation(),
    MyHomePage(),
    MySearchPage(),
    MyProfilePage()
  ];

  void myOnTap(int _index) {
    setState(() {
      _selectIndex = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetsPage.elementAt(_selectIndex),
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
}
