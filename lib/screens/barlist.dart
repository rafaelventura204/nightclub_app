import 'package:flutter/material.dart';

class MyBarList extends StatefulWidget {
  @override
  _MyBarListState createState() => _MyBarListState();
}

class _MyBarListState extends State<MyBarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTA LOCALI'),
        backgroundColor: Colors.purple[300],
      ),
      body: Text('Lista!'),
    );
  }
}
