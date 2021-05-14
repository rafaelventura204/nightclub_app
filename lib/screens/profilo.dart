import 'dart:io';
import 'package:bar_pub/screens/select_category.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locali Intrattenimento',
      debugShowCheckedModeBanner: false,
      home: MyProfilePage(title: 'Profilo'),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // Variables
  GlobalPreferences gPref = GlobalPreferences();
  SelectCategory selectCategory = SelectCategory();
  //File imageFile;
  dynamic tempCategory;

  @override
  Widget build(BuildContext context) {
    tempCategory = gPref.getCategoriesSF();
    print("$tempCategory [profilo]");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          finalName,
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0.0,
        backgroundColor: Colors.purple[300],
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              gPref.removeSF();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Wrapper()));
            },
            icon: Icon(
              Icons.person,
              color: Colors.black87,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.black87),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomPaint(
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 5.0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/profiloDefault.jpg'))),
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                SizedBox(height: 10.0),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectCategory()),
                        );
                      },
                      tooltip: 'Category',
                      child: Icon(Icons.add),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFBA68C8);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 255, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
