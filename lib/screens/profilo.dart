import 'package:bar_pub/screens/select_category.dart';
import 'package:bar_pub/screens/single_property_page.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/card_item.dart';
import 'package:bar_pub/widgets/stack_container.dart';
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
  LoadDataUser loadDataUser = LoadDataUser();
  String tmp = "";

  @override
  Widget build(BuildContext context) {
    setState(() {
      loadDataUser
          .getUserNightlifeFromDB(finalName)
          .whenComplete(() => print(""));
    });

    createAlertDialog(BuildContext context, Widget showUserCategory) {
      return showDialog(
        context: context,
        builder: (context) {
          return Opacity(
            opacity: 0.70,
            child: AlertDialog(
              actions: <Widget>[showUserCategory],
            ),
          );
        },
        useSafeArea: true,
        barrierColor: Colors.transparent,
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Category ',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
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
                              'Add',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
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
                                fontSize: 16.0,
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
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return viewNightlife.length > 0
                    ? new GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SinglePropertyPage(
                                      club: viewNightlife.elementAt(index))));
                        },
                        child: CardItem(index: index),
                      )
                    : new Text('Nessun locale selezionato');
              },
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              primary: false,
              itemCount: viewNightlife.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget showUserCategory() {
    return listUserCategory.isNotEmpty
        ? Container(
            height: 450.0,
            width: 350.0,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: listUserCategory.length,
              itemBuilder: (context, index) {
                return new Container(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Center(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: 195,
                                child: Text(
                                  listUserCategory
                                      .elementAt(index)
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""),
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 30,
                                color: Colors.transparent,
                                child: IconButton(
                                    icon:
                                        Icon(Icons.delete, color: Colors.white),
                                    onPressed: () => {
                                          setState(() {
                                            tmp = listUserCategory
                                                .elementAt(index);
                                            listUserCategory.remove(tmp);
                                            loadDataUser
                                                .removeUserCategoryFromDB(
                                                    finalName, tmp);
                                          })
                                        }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              "Nessuna categoria selezionata!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
