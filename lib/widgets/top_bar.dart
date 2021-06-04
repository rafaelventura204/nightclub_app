import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar({key}) : super(key: key);

  GlobalPreferences gPref = GlobalPreferences();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: TextButton.icon(
      onPressed: () async {
        gPref.removeSF();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      },
      icon: Icon(
        Icons.person,
        color: Colors.black87,
      ),
      label: Text(
        'Logout',
        style: TextStyle(color: Colors.black87),
      ),
    ));
  }
}
