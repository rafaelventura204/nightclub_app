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

final List<Property> viewNightlife = List<Property>();

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
  @override
  void initState() {
    setState(() {
      for (var item in myListNightlifes) {
        viewNightlife.add(Property(
          name: item.name,
          imagePath: item.urlImage,
          address: item.address,
          categories: item.categories,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // for (var item in myListNightlifes) {
    //   print("-> ${item.name}");
    // }

    print(myListNightlifes.length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
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
}
