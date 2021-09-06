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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
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
}
