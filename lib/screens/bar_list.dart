import 'dart:convert';
import 'dart:ui';

import 'package:bar_pub/screens/single_property_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarList extends StatefulWidget {
  @override
  _MyBarListState createState() => _MyBarListState();
}

class _MyBarListState extends State<MyBarList> {
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> createList() async {
      List<Widget> items = <Widget>[];
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);

      dataJSON.forEach((object) {
        String finalString = "";
        List<dynamic> dataList = object["placeItems"];
        dataList.forEach((items) {
          finalString = finalString + items + " | ";
        });
        items.add(Padding(
          padding: EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SinglePropertyPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple[100],
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                  ]),
              margin: EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      object["placeImage"],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(object["placeName"]),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 2.0, bottom: 2.0),
                            child: Text(finalString,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black54),
                                maxLines: 1),
                          ),
                          Text("Min.Order: ${object["minOrder"]}",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      });
      return items;
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(35),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          cursorColor: Colors.purple[300],
                          decoration: InputDecoration(
                              labelText: 'Cerca',
                              labelStyle: TextStyle(color: Colors.purple[300]),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.purple[300]),
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.forward),
                          onPressed: () {}, //aggiungere ricerca
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            //scrollDirection: Axis.vertical,
                            children: snapshot.data,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//SafeArea(child: SizedBox(height: 10.0)),
/*Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                    ),*/
/*SizedBox(
                  height: 15.0,
                ),*/
/*SizedBox(
                  height: 15.0,
                ),*/

/*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: TextFormField(
                        obscureText: false,
                        cursorColor: Colors.purple[300],
                        //onChanged: ,
                        decoration: InputDecoration(
                            /*prefixIcon: Icon(
                              Icons.search,
                              color: Colors.purple[300],
                            ),*/
                            labelText: 'Cerca',
                            labelStyle: TextStyle(color: Colors.purple[300]),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.7)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple[300]),
                                borderRadius: BorderRadius.circular(27.7))),
                      ),
                    ),
                  ],
                ),*/
/*Padding(
                  //padding: EdgeInsets.only(left: 180.0),
                  padding: EdgeInsets.fromLTRB(200, 0, 0, 0),

                  child: TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      "Vai!",
                      style: TextStyle(color: Colors.purple[300]),
                    ),
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.purple[300],
                    ),
                  ),
                ),*/
