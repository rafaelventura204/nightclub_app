import 'package:bar_pub/screens/barlist.dart';
import 'package:bar_pub/screens/homeScreen.dart';
import 'package:bar_pub/screens/profilo.dart';
import 'package:bar_pub/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectIndex = 0;

  final List<Widget> _widgetsPage = [
    MyHomeScreen(),
    MySearch(),
    MyBarList(),
    MyProfile()
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
            label: 'Mappa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'BarList',
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
