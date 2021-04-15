import 'package:flutter/material.dart';

class MyBarList extends StatefulWidget {
  @override
  _MyBarListState createState() => _MyBarListState();
}

class _MyBarListState extends State<MyBarList> {
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(top: 0.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SafeArea(child: SizedBox(height: 10.0)),
              /*Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),*/
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Cerca il tuo\nlocale",
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
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: false,
                  cursorColor: Colors.purple[300],
                  //onChanged: ,
                  decoration: InputDecoration(
                      /*prefixIcon: Icon(
                        Icons.search,
                        color: Colors.purple[300],
                      ),*/
                      labelText: 'Cerca',
                      labelStyle: TextStyle(color: Colors.purple[300]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple[300]),
                          borderRadius: BorderRadius.circular(27.7))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 180.0),
                child: TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    "Vai!",
                    style: TextStyle(color: Colors.purple[300]),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.purple[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
