import 'package:bar_pub/screens/authenticate/autenticate.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* F I R E B A S E*/
    //return home or authenticate widget

    /*String username = "";

    final user = Provider.of<MyUser>(context);
    print("${user}qua");

    if (user == null) {
      return Authenticate();
    } else {
      return MyHome();
    }
  }
  return Authenticate();
  */
    String nameUser;
    Future getValidation() async {
      SharedPreferences userPreferences = await SharedPreferences.getInstance();
      var nameUsertemp = userPreferences.getString('name_user');
      nameUser = nameUsertemp;
    }

    getValidation()
        .whenComplete(() => (nameUser == null ? Authenticate() : MyHome()));

    /*if (nameUser == null) {
      return Authenticate();
    } else {
      return MyHome();
    }*/
  }
}
