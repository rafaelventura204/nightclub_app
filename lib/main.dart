import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SharedPreferences.getInstance().then((value) => value.clear());
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
