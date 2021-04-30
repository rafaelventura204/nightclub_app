//import 'package:bar_pub/screens/single_property_page.dart';
import 'package:bar_pub/services/static_data.dart';
import 'package:bar_pub/widgets/club_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalName;

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
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    dynamic stringValue = prefs.getString('name_user');
    //finalName = stringValue;
    print("${finalName.toString()}[FUCK THE WORLD1]");

    return stringValue;
  }

  @override
  Widget build(BuildContext context) {
    finalName = getStringValuesSF();
    print("$finalName[FUCK THE WORLD2]");
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      //designSize: Size(360, 690),
      //orientation: Orientation.portrait
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SafeArea(child: SizedBox(height: 10.0)),
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.purple[300],
                      radius: 22.0,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            AssetImage("assets/images/profiloProva.png"),
                      ),
                    )
                  ],
                ),
              ),*/
              SizedBox(
                height: 25.0,
              ),
              //"Trova il tuo\nlocale",
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("$finalName",
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
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Popular",
                  style: TextStyle(
                    fontSize: 18.0,
                    height: 1.5,
                    color: Color.fromRGBO(33, 45, 82, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),*/
              /*SizedBox(
                height: 10.0,
              ),*/
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
