import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatefulWidget {
  TopBar({key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  GlobalPreferences gPref = GlobalPreferences();

  @override
  Widget build(BuildContext context) {
    return finalName != null
        ? SafeArea(
            child: TextButton.icon(
            onPressed: () async {
              finalName = null;
              //Navigator.pop(context);
              gPref.removeSF();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()),
              );
              /*Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper()),
                  ModalRoute.withName("/Wrapper"));*/
            },
            icon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.black87),
            ),
          ))
        : SafeArea(
            child: TextButton.icon(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => Wrapper()),
              );
              /*Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper()),
                  ModalRoute.withName("/Wrapper"));*/
            },
            /* async {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Wrapper()));
            },*/
            icon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            label: Text(
              'LogIN',
              style: TextStyle(color: Colors.black87),
            ),
          ));
  }
}
