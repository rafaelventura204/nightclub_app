import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/maps/map_polyline.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePropertyPage extends StatefulWidget {
  final Property club;
  const SinglePropertyPage({Key key, @required this.club}) : super(key: key);

  @override
  _SinglePropertyPageState createState() => _SinglePropertyPageState();
}

class _SinglePropertyPageState extends State<SinglePropertyPage> {
  bool liked = false; //salvare in una varibile sharedpreferences
  LoadDataUser loadDataUser = LoadDataUser();

  _pressed() {
    setState(() {
      liked = !liked;
    });
    if (liked == true) {
      print("true -> aggiungere elemento");
      loadDataUser.loadUserNightlifeToDB(finalName, widget.club.id);
    } else {
      loadDataUser.removeUserNightlifeFromDB(finalName, widget.club.id);
      print("false -> rimuovi elemento");
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var item in viewNightlife) {
      if (widget.club.id == item.id) {
        print("wid: ${widget.club.id} night: ${item.id}");
        liked = true;
      }
    }

    return Material(
      type: MaterialType.transparency,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                      height: 230.0,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        child: Image(
                          image: NetworkImage(widget.club.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 50.0,
                      width: 50.0,
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(left: 10.0, top: 30.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30.0,
                        color: Colors.white,
                        tooltip: 'Back',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Container(
                      height: 112,
                      margin: EdgeInsets.only(top: 180),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.club.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  height: 1.5,
                                  color: Color.fromRGBO(35, 45, 82, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                    liked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: liked
                                        ? Colors.purple
                                        : Color(0xFFBA68C8)),
                                onPressed: () => _pressed(),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMapPolylinePage(
                                          latitudineNightlife:
                                              widget.club.latitudine,
                                          longitudineNightlife:
                                              widget.club.longitudine)),
                                );
                              },
                              icon: Icon(
                                FlutterIcons.map_pin_fea,
                                color: Color.fromRGBO(138, 150, 190, 1),
                              ),
                              label: Text(
                                widget.club.address.toString(),
                                style: GoogleFonts.inter(
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(64, 74, 104, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.club.description,
                        style: GoogleFonts.inter(
                          fontSize: 18.0,
                          color: Color.fromRGBO(64, 74, 104, 1),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    child: Wrap(
                        runSpacing: 8.0,
                        spacing: 8.0,
                        children: widget.club.categories
                            .map(
                              (category) => Chip(
                                labelPadding: EdgeInsets.all(4),
                                label: Text(category
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')),
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.purple[300],
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
