import 'dart:async';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsClient extends StatefulWidget {
  GoogleMapsClient();

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMapsClient> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = LatLng(45.464664, 9.188540);
  final Set<Marker> _markers = {};
  Location location = new Location();
  var filterdis;

  void placeAllMarkers() async {
    var latitudine, longitudine, clubName, clubDesc, clubID;

    for (int i = 0; i < defaultListNightlife.length; i++) {
      clubID = defaultListNightlife.elementAt(i).id;
      clubName = defaultListNightlife.elementAt(i).name;
      clubDesc = defaultListNightlife.elementAt(i).description;
      latitudine = defaultListNightlife.elementAt(i).latitudine;
      longitudine = defaultListNightlife.elementAt(i).longitutidine;
      _addMarkers(latitudine, longitudine, clubName, clubDesc, clubID);
    }
  }

  void _addMarkers(latitude, longitude, clubName, clubDesc, clubID) {
    LatLng _nightClubPosition = LatLng(latitude, longitude);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_nightClubPosition.toString()),
        position: _nightClubPosition,
        infoWindow: InfoWindow(
          title: clubName,
          // snippet: clubDesc,
          // onTap: () => {},
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(270.0),
      ));
    });
  }

  Future<void> _userPosition() async {
    GoogleMapController mapController = await _controller.future;
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 18.0,
    )));
  }

  void _onMapCreated(GoogleMapController controller) {
    location.requestPermission();
    _controller.complete(controller);
  }

  Widget googleMapsCreation() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 13,
      ),
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      rotateGesturesEnabled: true,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      markers: _markers,
    );
  }

  //filter markers based on distance
  // filterMarkers(dist) {
  //   for (int i = 0; i < defaultListNightlife.length; i++) {
  //     var then = Geolocator.distanceBetween(
  //         45.464664,
  //         9.188540,
  //         defaultListNightlife.elementAt(i).latitudine,
  //         defaultListNightlife.elementAt(i).longitutidine);

  //     if (then / 1000 < double.parse(dist)) {
  //       print("${then / 1000} distanza");
  //       print("promossi:${defaultListNightlife.elementAt(i).name}");
  //       placeFilteredMarker(
  //           defaultListNightlife.elementAt(i).latitudine,
  //           defaultListNightlife.elementAt(i).longitutidine,
  //           defaultListNightlife.elementAt(i).name,
  //           defaultListNightlife.elementAt(i).id,
  //           then / 1000);
  //     }
  //   }
  // }

  // placeFilteredMarker(lat, lon, name, id, distance) {
  //   LatLng _nightClubPosition = LatLng(lat, lon);
  //   setState(() {
  //     //_markers.clear();
  //     print("elementi markers: ${_markers.length}");
  //     _markers.add(Marker(
  //       markerId: MarkerId(_nightClubPosition.toString()),
  //       position: _nightClubPosition,
  //       infoWindow: InfoWindow(
  //         title: name,
  //         snippet: distance.toString(),
  //         onTap: () => {},
  //       ),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(30.0),
  //     ));
  //   });
  // }*/

  @override
  Widget build(BuildContext context) {
    placeAllMarkers();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Nightlife',
          style: TextStyle(color: Colors.purple[300], fontSize: 30),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: getDistance,
        //   ),
        // ],
        /*title: Text(
          'Nightlife',
          style: TextStyle(color: Colors.purple[300], fontSize: 30),
        ),*/
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(children: <Widget>[
          googleMapsCreation(),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                SizedBox(height: 3),
                FloatingActionButton(
                  //premier bouton qui recentre la position selon _center centre de paris
                  onPressed: _userPosition,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.center_focus_weak,
                    size: 30,
                    color: Color(0xFF7854d3),
                  ),
                ),
                SizedBox(height: 30),
//                FloatingActionButton(
//                  // deuxieme bouton ajoute un marker au centre de l'appli
//                  onPressed: _onAddMarkerButtonPressed,
//                  materialTapTargetSize: MaterialTapTargetSize.padded,
//                  backgroundColor: Theme
//                      .of(context)
//                      .primaryColor,
//                  child: const Icon(Icons.add_location, size: 50),
//                ),
              ],
            ),
          ),
        ]),
        constraints: BoxConstraints(
            maxHeight: double.infinity, maxWidth: double.infinity),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  // Future<bool> getDistance() {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Enter Distance'),
  //           contentPadding: EdgeInsets.all(10.0),
  //           content: TextField(
  //             decoration: InputDecoration(hintText: 'Enter distance'),
  //             onChanged: (val) {
  //               setState(() {
  //                 filterdis = val;
  //               });
  //             },
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('OK'),
  //               color: Colors.transparent,
  //               textColor: Colors.purple,
  //               onPressed: () {
  //                 filterMarkers(filterdis);
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
}
