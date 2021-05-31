import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/single_property_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubList extends StatelessWidget {
  final Property club;
  ClubList({this.club});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePropertyPage(club: club)));
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
              child: Image.network(
                club.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            /*SizedBox(
              //width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(club.name),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text('CATEGORIES',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black54),
                          maxLines: 1),
                    ),
                    Text(club.distance,
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.black54)),
                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
