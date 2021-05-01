import 'package:bar_pub/screens/authenticate/autenticate.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalOttieniNome;

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    getValidation().whenComplete(() async {
      if (finalOttieniNome == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Authenticate()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome()));
      }
    });
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var ottieniNoME = sharedPreferences.getString('name_user');

    setState(() {
      finalOttieniNome = ottieniNoME;
    });
    print(finalOttieniNome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Wait...")),
    );
  }
}

/*class Wrapper extends StatelessWidget {

  
  GlobalPreferences gPref = GlobalPreferences();
  String userLog;

  @override
  Widget build(BuildContext context) {
    if (gPref.myUser.nameUser == null)
      return Authenticate();
    else
      return MyHome();
  }
}*/
