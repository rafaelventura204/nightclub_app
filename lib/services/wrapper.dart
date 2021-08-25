import 'package:bar_pub/screens/Welcome/welcome_screen.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalName = null;
var myLatitudine = 45.42573338550383;
var myLongitudine = 9.202500141406698;
LoadDataUser loadDataUser = LoadDataUser();
StaticData staticData = StaticData();

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    getValidation().whenComplete(() async {
      if (finalName == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeScreen())); //Authenticate() => swapTo Welcome
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome()));
      }
    });
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferencesName =
        await SharedPreferences.getInstance();
    var getName = sharedPreferencesName.getString('name_user');

    setState(() {
      finalName = getName;
    });
    print(finalName);
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
