import 'package:bar_pub/screens/bar_list.dart';
import 'package:bar_pub/screens/home/home_screen.dart';
import 'package:bar_pub/screens/maps/google_maps_client.dart';
import 'package:bar_pub/screens/profilo.dart';
import 'package:bar_pub/screens/maps/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//String finalName;

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
    //MySearch(),
    MyBarList(),
    GoogleMapsClient(),
    MyProfile()
  ];

  void myOnTap(int _index) {
    setState(() {
      _selectIndex = _index;
    });
  }

  /*@override
  void initState() {

  }*/

  /*Future getValidation() async {
    SharedPreferences localnameUser = await SharedPreferences.getInstance();
    var nameUser = localnameUser.getString('name_user');
    setState(() {
      finalName = nameUser;
    });
    print(finalName);

  }*/

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
          /*BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Mappa',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'BarList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
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
