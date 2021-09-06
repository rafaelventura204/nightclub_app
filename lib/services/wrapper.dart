import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bar_pub/screens/Welcome/welcome_screen.dart';
import 'package:bar_pub/screens/home/home.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalName = null;
bool activeCategory = true, activeDistance = true;
double currentSliderValue = 5;
var myLatitudine = 45.42573338550383;
var myLongitudine = 9.202500141406698;
LoadDataUser loadDataUser = LoadDataUser();
StaticData staticData = StaticData();

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    getValidation().whenComplete(() async {
      if (finalName == null) {
        loadDataUser.loadData().whenComplete(() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
        //Authenticate() => swapTo Welcome
      } else {
        loadDataUser.loadData().whenComplete(() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHome())));
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Please wait...',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Center(
              child: CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
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