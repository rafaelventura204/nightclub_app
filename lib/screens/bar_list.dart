import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/single_property_page.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:bar_pub/widgets/club_card.dart';
import 'package:bar_pub/widgets/club_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarList extends StatefulWidget {
  // final Property club;
  // MyBarList();
  @override
  _MyBarListState createState() => _MyBarListState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _MyBarListState extends State<MyBarList> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<Property> nightlife = List();
  List<Property> filteredNightlife = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      nightlife = StaticData.properties;
      filteredNightlife = nightlife;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Cerca il tuo\nlocale",
                  style: GoogleFonts.inter(
                    fontSize: 30.0,
                    height: 1.5,
                    color: Color.fromRGBO(33, 45, 82, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Enter name or category'),
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filteredNightlife = nightlife
                          .where((e) => (e.name
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              e.address
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    });
                  });
                },
              ),
              SizedBox(
                height: 55.0,
              ),
              SizedBox(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: filteredNightlife.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SinglePropertyPage(
                                      club:
                                          filteredNightlife.elementAt(index))));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2.0,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            margin: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                  child: Image.network(
                                    filteredNightlife
                                        .elementAt(index)
                                        .imagePath,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(filteredNightlife
                                            .elementAt(index)
                                            .name),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 2.0),
                                          child: Text(
                                              filteredNightlife
                                                  .elementAt(index)
                                                  .address,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                              maxLines: 1),
                                        ),
                                        Text(
                                            "${nightlife.elementAt(index).distance} km",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black54))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    }),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
