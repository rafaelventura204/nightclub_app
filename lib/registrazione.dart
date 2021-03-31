import 'package:flutter/material.dart';

class MyRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locali Intrattenimento',
      home: MyRegistrationPage(
        title: 'Registrazione',
      ),
    );
  }
}

class MyRegistrationPage extends StatefulWidget {
  MyRegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyRegistrationPage createState() => _MyRegistrationPage();
}

class _MyRegistrationPage extends State<MyRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione'),
      ),
    );
  }
}
