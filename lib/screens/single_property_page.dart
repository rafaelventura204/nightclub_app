import 'package:bar_pub/screens/map_polyline.dart';
import 'package:bar_pub/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePropertyPage extends StatelessWidget {
  final String name, description, image, price;
  SinglePropertyPage(this.name, this.description, this.image, this.price);

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
                  width: size.width,
                  child: Container(
                    height: size.height,
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(
                                'https://b.zmtcdn.com/data/pictures/8/18221798/623fb2a9f6d540385bb4b0d760a3efec.jpg')

                            //AssetImage("assets/images/provaNavi2.png"),
                            )),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    color: Colors.purple[900],
                    tooltip: 'Back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 26.0,
                    //textDirection: TextDirection.ltr,
                  ),
                ),
                Positioned(
                  top: 270.0,
                  width: size.width,
                  child: Container(
                    height: heightFromWhiteBg,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 18.0,
                                height: 1.5,
                                color: Color.fromRGBO(35, 45, 82, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: Color(0xFFBA68C8),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(FlutterIcons.map_pin_fea),
                              color: Color.fromRGBO(138, 150, 190, 1),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //builder: (context) => MapPolyline()
                                      builder: (context) => MySearch()),
                                );
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Milano, Ripamonti",
                                style: GoogleFonts.inter(
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(64, 74, 104, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            description,
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

/* 
class SinglePropertyPage extends StatefulWidget {
  @override
  SinglePropertyState createState() => SinglePropertyState();
}

class SinglePropertyState extends State<SinglePropertyPage> {
  final String nameLocale;
  SinglePropertyState(this.nameLocale);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        child: SingleChildScrollView(),
      ),
    );
  }
}

*/

/* S A F E
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        double heightFromWhiteBg = size.height - 250.0; //Spazio bianco
        return Container(
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                width: size.width,
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/images/provaNavi2.png"),
                  )),
                ),
              ),
              Positioned(
                top: 30.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_outlined),
                  color: Colors.white,
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 24.0,
                  //textDirection: TextDirection.ltr,
                ),
              ),
              Positioned(
                top: 350.0,
                width: size.width,
                child: Container(
                  height: heightFromWhiteBg,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18.0,
                              height: 1.5,
                              color: Color.fromRGBO(35, 45, 82, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Color(0xFFBA68C8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(FlutterIcons.map_pin_fea),
                            color: Color.fromRGBO(138, 150, 190, 1),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapPolyline()),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              "Milano, Ripamonti",
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                                color: Color.fromRGBO(64, 74, 104, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Il miglior locale a Milano, vicino a te non perdere l'opportunità di visitare questo meraviglioso locale alle porte di milano.",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15.0,
                          height: 1.5,
                          color: Color.fromRGBO(138, 150, 190, 1),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 16.0, right: 5.0),
                        height: ScreenUtil().setHeight(56.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFBA68C8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "120£",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                ),
                                TextSpan(
                                  text: "night",
                                  style: GoogleFonts.inter(),
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


*/
