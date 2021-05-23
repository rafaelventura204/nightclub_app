import 'package:bar_pub/screens/select_category.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/load_data_user.dart';
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
  LoadDataUser loadDataUser = LoadDataUser();
  String tmp = "";

  @override
  Widget build(BuildContext context) {
    loadDataUser.getUserCategoryFromDB(finalName);

    createAlertDialog(BuildContext context, Widget showUserCategory) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Categorie'),
            actions: <Widget>[showUserCategory],
          );
        },
        useSafeArea: true,
      );
    }

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
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Category: '),
                    SizedBox(
                      height: 25.0,
                      width: 55.0,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[600]),
                          child: Align(
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              alignment: Alignment(0.1, 0.1)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectCategory()),
                          ).then((value) => setState(() => {}));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                      width: 55.0,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey[600]),
                          child: Align(
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              alignment: Alignment(0.1, 0.1)),
                        ),
                        onTap: () {
                          createAlertDialog(context, showUserCategory());
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showUserCategory() {
    return Container(
      height: 300.0,
      width: 300.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listUserCategory.length,
        itemBuilder: (context, index) {
          return Container(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          listUserCategory
                              .elementAt(index)
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete_sweep_outlined),
                            onPressed: () => {
                                  tmp = listUserCategory.elementAt(index),
                                  listUserCategory.remove(tmp),
                                  loadDataUser.removeUserCategoryFromDB(
                                      finalName, tmp),
                                  setState(() {})
                                })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
