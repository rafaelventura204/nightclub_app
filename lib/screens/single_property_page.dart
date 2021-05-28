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
  static bool liked = false; //salvare in una varibile sharedpreferences
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        double heightFromWhiteBg = size.height - 250.0; //Spazio bianco
        return SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: size.height - 440.0,
                    decoration: BoxDecoration(boxShadow: []),
                    child: ClipRRect(
                      child: Image(
                        image: NetworkImage(widget.club.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.white,
                    tooltip: 'Back',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 180.0,
                  width: size.width,
                  child: Container(
                    height: heightFromWhiteBg,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.club.name,
                              style: TextStyle(
                                fontSize: 18.0,
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
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton.icon(
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
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(64, 74, 104, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            widget.club.description,
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              color: Color.fromRGBO(64, 74, 104, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
