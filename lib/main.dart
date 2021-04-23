//import 'package:bar_pub/models/user.dart';
import 'package:bar_pub/services/wrapper.dart';
//import 'package:bar_pub/services/auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

void main() {
  //async
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); -> F I R E B A S E
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

/* F I R E B A S E*/
/*Questo stream è in ascolto, nel caso l'utente sia loggato e nel caso l'utente non sia loggato*/
/*return StreamProvider<MyUser>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    ); */
