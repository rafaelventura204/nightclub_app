import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/widgets/stack_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyProfileGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locali Intrattenimento',
      debugShowCheckedModeBanner: false,
      home: MyProfileGuestPage(title: 'Profilo'),
    );
  }
}

class MyProfileGuestPage extends StatefulWidget {
  MyProfileGuestPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyProfileGuestPageState createState() => _MyProfileGuestPageState();
}

class _MyProfileGuestPageState extends State<MyProfileGuestPage> {
  LoadDataUser loadDataUser = LoadDataUser();
  String tmp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            //inizio
            // Container(
            //   margin: EdgeInsets.only(top: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         'Category ',
            //         style: TextStyle(
            //           fontSize: 21.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 25.0,
            //         width: 55.0,
            //         child: InkWell(
            //           child: Container(
            //             decoration: BoxDecoration(color: Colors.grey[600]),
            //             child: Align(
            //                 child: Text(
            //                   'Add',
            //                   style: TextStyle(
            //                       color: Colors.white, fontSize: 16.0),
            //                 ),
            //                 alignment: Alignment(0.1, 0.1)),
            //           ),
            //           onTap: () {
            //             //pop => effettua il login per poter selezinare la categoria!!!
            //             const snackBar =
            //                 SnackBar(content: Text('Utente non trovato!'));
            //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //           },
            //         ),
            //       ),
            //       SizedBox(
            //         height: 25.0,
            //         width: 55.0,
            //         child: InkWell(
            //           child: Container(
            //             decoration: BoxDecoration(color: Colors.grey[600]),
            //             child: Align(
            //                 child: Text(
            //                   'View',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 16.0,
            //                   ),
            //                 ),
            //                 alignment: Alignment(0.1, 0.1)),
            //           ),
            //           onTap: () {
            //             //pop => effettua il login per poter selezinare la categoria!!!
            //             const snackBar =
            //                 SnackBar(content: Text('Utente non trovato!'));
            //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //fine
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    // per poter usufruire di tutti i vantaggi!!(frase da rivdere!)"
                    "Effettua il login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  //fine
}
