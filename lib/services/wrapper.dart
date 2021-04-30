import 'package:bar_pub/screens/authenticate/autenticate.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  Future getValidation() async {
    SharedPreferences userPreferences = await SharedPreferences.getInstance();
    var nameUsertemp = userPreferences.getString('name_user');

    return nameUsertemp;
  }

  @override
  Widget build(BuildContext context) {
    /*dynamic temp = getValidation();

    print("${temp.runtimeType}SONO ANCORA QUAAAAAA");

    if (temp == null)
      return Authenticate();
    else
      return MyHome();*/
    return Authenticate();
  }
}
