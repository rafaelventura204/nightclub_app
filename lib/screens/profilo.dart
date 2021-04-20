import 'dart:io';
import 'package:bar_pub/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:filter_list/filter_list.dart';

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
  /// Variables
  File imageFile;
  final AuthService _auth = AuthService();

  /*SCELTA CATEGORIE */
  List<String> countList = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Tweleve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen",
    "Twenty"
  ];
  List<String> selectedCountList = [];

  void _openFilterDialog() async {
    await FilterListDialog.display(context,
        listData: countList,
        selectedListData: selectedCountList,
        height: 480,
        headlineText: "Select Count",
        searchFieldHintText: "Search Here", label: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list.contains(val);
    }, onItemSearch: (list, text) {
      if (list.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          selectedCountList = List.from(list);
        });
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inserisci nome",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0.0,
        backgroundColor: Colors.purple[300],
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
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
                      onPressed: _openFilterDialog,
                      tooltip: 'Category',
                      child: Icon(Icons.add),
                    )),
                /*SafeArea(
                  child: FilterListWidget(
                    listData: countList,
                    hideheaderText: true,
                    onApplyButtonClick: (list) {
                      if (list != null) {
                        print("Selected items count: ${list.length}");
                      }
                    },
                    label: (item) {
                      /// Used to print text on chip
                      return item.name;
                    },
                    validateSelectedItem: (list, val) {
                      ///  identify if item is selected or not
                      return list.contains(val);
                    },
                    onItemSearch: (list, text) {
                      /// When text change in search text field then return list containing that text value
                      ///
                      ///Check if list has value which matchs to text
                      if (list.any((element) => element.name
                          .toLowerCase()
                          .contains(text.toLowerCase()))) {
                        /// return list which contains matches
                        return list
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                      }
                    },
                  ),
                ),*/
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

/* CODICE PROVVISORIO */

//Get from Gallery
/*_getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }*/

/// Get from Camera
/*_getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }*/

/**/
