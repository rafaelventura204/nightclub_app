import 'dart:ui';
import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/single_property_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubCard extends StatelessWidget {
  final Property club;
  ClubCard({this.club});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePropertyPage(
                      club: club,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: ScreenUtil().setHeight(25.0),
          width: ScreenUtil().setWidth(300.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 1.3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(club.imagePath))),
              )),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        club.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(33, 45, 82, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        club.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromRGBO(128, 150, 190, 1),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Orario\n",
                                style: GoogleFonts.inter(
                                  color: Color.fromRGBO(64, 74, 106, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                )),
                            TextSpan(
                                text: club.hour,
                                style: GoogleFonts.inter(
                                  //color: Color.fromRGBO(33, 45, 82, 1),
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                )),
                          ])),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Distanza\n",
                                style: GoogleFonts.inter(
                                  color: Color.fromRGBO(64, 74, 106, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.0,
                                )),
                            TextSpan(
                                text: "${club.distance} km",
                                style: GoogleFonts.inter(
                                  //color: Color.fromRGBO(33, 45, 82, 1),
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0,
                                )),
                          ])),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
