import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/club_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//var myLatitudine, myLongitudine;

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomeScreenPage(),
    );
  }
}

class MyHomeScreenPage extends StatefulWidget {
  @override
  _MyHomeScreenPageState createState() => _MyHomeScreenPageState();
}

class _MyHomeScreenPageState extends State<MyHomeScreenPage> {
  LoadDataUser loadDataUser = LoadDataUser();
  StaticData staticData = StaticData();

  /*@override
  void initState() {
    super.initState();
    loadDataUser.getUserNightlifeFromDB(finalName);
    staticData.addNightlife();
  }*/

  @override
  Widget build(BuildContext context) {
    //loadDataUser.getUserNightlifeFromDB(finalName);
    /*myLatitudine = 45.42573338550383;
    myLongitudine = 9.202500141406698;*/

    //staticData.addNightlife();
    /*  setState(() {
      loadDataUser.getUserNightlifeFromDB(finalName);
      staticData.addNightlife();
    });
*/
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.5),
                child: Text('Trova il tuo\nlocale\n',
                    style: TextStyle(
                      fontSize: 30.0,
                      height: 1.5, //togliere o lasciare
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 45.0,
              ),
              Container(
                  height: ScreenUtil().setHeight(400.0),
                  /*Immagini grandi perchè è bello vedere in primo piano
                  una bella foto del locale, serve per farsi un'idea di com'è
                  fatto il locale, così facendo il l'utente rimarrà più tempo 
                  all'interno dell'applicazione evitando che esca a cerca nel 
                  web immagini del locale.
                   */
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return ClubCard(
                          club: StaticData.properties[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 20.0,
                        );
                      },
                      itemCount: StaticData.properties.length)),
              SizedBox(height: 10.0)
            ],
          ),
        ),
      ),
    );
  }
}
