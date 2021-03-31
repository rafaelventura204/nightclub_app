import 'package:bar_pub/models/user.dart';
import 'package:bar_pub/screens/authenticate/autenticate.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticate widget

    final user = Provider.of<MyUser>(context);
    print("${user}qua");

    if (user == null) {
      return Authenticate();
    } else {
      return MyHome();
    }
  }
}
