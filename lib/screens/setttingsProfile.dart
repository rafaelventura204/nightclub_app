import 'package:bar_pub/screens/select_category.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:bar_pub/widgets/constants.dart';
import 'package:flutter/material.dart';

class SettingsProfile extends StatefulWidget {
  @override
  _SettingsProfileState createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  LoadDataUser loadDataUser = LoadDataUser();
  String tmp = "";

  Widget showUserCategory() {
    return listUserCategory.isNotEmpty
        ? Container(
            height: 450.0,
            width: 350.0,
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: listUserCategory.length,
              itemBuilder: (context, index) {
                return new Container(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Center(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: 195,
                                child: Text(
                                  listUserCategory
                                      .elementAt(index)
                                      .replaceAll("[", "")
                                      .replaceAll("]", ""),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                width: 30,
                                color: Colors.transparent,
                                child: IconButton(
                                    icon:
                                        Icon(Icons.delete, color: Colors.white),
                                    onPressed: () => {
                                          setState(() {
                                            tmp = listUserCategory
                                                .elementAt(index);
                                            listUserCategory.remove(tmp);
                                            loadDataUser
                                                .removeUserCategoryFromDB(
                                                    finalName, tmp);
                                          })
                                        }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              "Nessuna categoria selezionata!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      loadDataUser
          .getUserNightlifeFromDB(finalName)
          .whenComplete(() => print(""));
    });

    createAlertDialog(BuildContext context, Widget showUserCategory) {
      return showDialog(
        context: context,
        builder: (context) {
          return Opacity(
            opacity: 0.70,
            child: AlertDialog(
              actions: <Widget>[showUserCategory],
            ),
          );
        },
        useSafeArea: true,
        barrierColor: Colors.transparent,
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: <Widget>[
            Text(
              'Impostazioni',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.purple),
                    title: Text("Aggiungi categoria"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCategory()),
                      ).then((value) => setState(() => {}));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.view_headline_outlined,
                        color: Colors.purple),
                    title: Text("Visualizza categorie"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      createAlertDialog(context, showUserCategory())
                          .then((value) => setState(() => {}));
                    },
                  ),
                ],
              ),
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   margin: EdgeInsets.only(top: 20, left: 0.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     textDirection: TextDirection.ltr,
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
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => SelectCategory()),
            //             ).then((value) => setState(() => {}));
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
            //             createAlertDialog(context, showUserCategory());
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.0),
            Text(
              "Algoritmo ricerca locali",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SwitchListTile(
              activeColor: Colors.purple,
              contentPadding: const EdgeInsets.all(0),
              value: activeCategory,
              title: Text('Categoria'),
              onChanged: (val) {
                setState(() {
                  activeCategory = val;
                });
              },
            ),
            SwitchListTile(
              activeColor: Colors.purple,
              contentPadding: const EdgeInsets.all(0),
              value: activeDistance,
              title: Text('Distanza'),
              onChanged: (val) {
                setState(() {
                  activeDistance = val;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Distanza massima",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Slider(
              inactiveColor: kPrimaryLightColor,
              activeColor: kPrimaryColor,
              value: currentSliderValue,
              min: 0,
              max: 50,
              divisions: 10,
              label: currentSliderValue.round().toString() + " km",
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
