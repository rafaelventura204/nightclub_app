import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/club_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

var myLatitudine, myLongitudine;

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
  //Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    // _getCurrentLocation();
    // myLatitudine = _currentPosition.latitude;
    // myLongitudine = _currentPosition.longitude;
    loadDataUser.getUserNightlifeFromDB(finalName);
    myLatitudine = 45.42573338550383;
    myLongitudine = 9.202500141406698;
    loadDataUser.getNightlifeFromDB();
    staticData.addNightlife();
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
              SafeArea(child: SizedBox(height: 10.0)),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Trova il tuo\nlocale\n',
                    style: TextStyle(
                      fontSize: 30.0,
                      height: 1.5,
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 55.0,
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

  /*_getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);}*/

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
}

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locali Intrattenimento'),
        backgroundColor: Colors.purple[300],
        elevation: 0.0,
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.wine_bar),
                title: Text('NOME LOCALE/DISCOTECA'),
                subtitle: Text('AGGIUNGERE PICCOLA DESCRIZIONE'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('AGGIUNGI PREFERITI'),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/
