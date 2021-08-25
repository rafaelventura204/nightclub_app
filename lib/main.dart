import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/constants.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SharedPreferences.getInstance().then((value) => value.clear());
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/wrapper': (context) => Wrapper(),
      },
      debugShowCheckedModeBanner: false,
      //home: WelcomeScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Wrapper(),
    );
  }
}
