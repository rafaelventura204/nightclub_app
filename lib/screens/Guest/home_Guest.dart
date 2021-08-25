import 'package:bar_pub/screens/Guest/home_screen_Guest.dart';
import 'package:bar_pub/screens/Guest/profilo_Guest.dart';
import 'package:bar_pub/screens/bar_list.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomeGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: MyHomeGuestPage(title: 'Home'),
    );
  }
}

class MyHomeGuestPage extends StatefulWidget {
  MyHomeGuestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeGuestPageState createState() => _MyHomeGuestPageState();
}

class _MyHomeGuestPageState extends State<MyHomeGuestPage> {
  int _selectIndex = 0;
  LoadDataUser loadDataUser = LoadDataUser();

  final List<Widget> _widgetsPage = [
    MyHomeScreenGuest(),
    MyBarList(),
    MyProfileGuest()
  ];

  void myOnTap(int _index) {
    setState(() {
      _selectIndex = _index;
    });
  }

  @override
  void initState() {
    loadDataUser.loadData();
    super.initState();
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
