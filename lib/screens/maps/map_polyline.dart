import 'package:flutter/material.dart';

class MapPolyline extends StatefulWidget {
  @override
  _MapPolylineState createState() => _MapPolylineState();
}

class _MapPolylineState extends State<MapPolyline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            color: Colors.black,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 24.0,
          )
        ],
      ),
      body: Text("Aggiungere mapp!"),
    );
  }
}
