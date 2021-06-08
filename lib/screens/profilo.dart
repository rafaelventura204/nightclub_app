import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/select_category.dart';
import 'package:bar_pub/screens/single_property_page.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/card_item.dart';
import 'package:bar_pub/widgets/custom_clipper.dart';
import 'package:bar_pub/widgets/stack_container.dart';
import 'package:bar_pub/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

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
  /*void initState() {
    setState(() {
      for (int i = 0; i < myListNightlifes.length; i++) {
        if (!viewNightlife
            .elementAt(i)
            .name
            .contains(myListNightlifes.elementAt(i).name)) {
          viewNightlife.add(Property(
            name: myListNightlifes.elementAt(i).name,
            imagePath: myListNightlifes.elementAt(i).urlImage,
            address: myListNightlifes.elementAt(i).address,
            categories: myListNightlifes.elementAt(i).categories,
            description: myListNightlifes.elementAt(i).description,
            latitudine: myListNightlifes.elementAt(i).latitudine,
            longitudine: myListNightlifes.elementAt(i).longitutidine,
          ));
        }
      }
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    print(viewNightlife.length);
    loadDataUser.getUserCategoryFromDB(finalName);
    //loadDataUser.getUserNightlifeFromDB(finalName);
    //inizio
    createAlertDialog(BuildContext context, Widget showUserCategory) {
      return showDialog(
        context: context,
        builder: (context) {
          return Opacity(
            opacity: 0.70,
            child: AlertDialog(
              //title: Text('Categorie'),
              actions: <Widget>[showUserCategory],
            ),
          );
        },
        //useSafeArea: true,
      );
    }

    //fine
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            //inizio
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
            //fine
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SinglePropertyPage(
                                club: viewNightlife.elementAt(index))));
                  },
                  child: CardItem(index: index),
                );
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

  //inizio
  Widget showUserCategory() {
    return Container(
      height: 350.0,
      width: 300.0,
      color: Colors.black, //.withOpacity(0.25),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listUserCategory
                              .elementAt(index)
                              .replaceAll("[", "")
                              .replaceAll("]", ""),
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.white),
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
  //fine
}
