import 'package:bar_pub/services/static_data.dart';
import 'package:bar_pub/widgets/club_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  @override
  Widget build(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SafeArea(child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //sistemare la poszione dell'avatar!!!!!!!!!!!!
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20.0,
                      backgroundImage: AssetImage("images/profiloProva.png"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Trova il tuo\nlocale",
                    style: TextStyle(
                      fontSize: 26.0,
                      height: 1.5,
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
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
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  height: ScreenUtil().setHeight(300.0),
                  //CREA I MODELLI DELLE CARD
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        //Created a property card widget
                        return ClubCard(
                          club: StaticData.properties[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.0,
                        );
                      },
                      itemCount: StaticData.properties.length))
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
