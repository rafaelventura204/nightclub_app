import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:postgres/postgres.dart';

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

  void placeAllMarkers() async {
    /*QuerySnapshot snapshot =
        await Firestore.instance.collection('club').getDocuments();
    for (int i = 0; i < snapshot.documents.length; i++) {
      _addMarkers(
          snapshot.documents[i]['position'].latitude,
          snapshot.documents[i]['position'].longitude,
          snapshot.documents[i]['name'],
          snapshot.documents[i]['description'],
          snapshot.documents[i].documentID);
    }*/
    var connection = PostgreSQLConnection(
      '192.168.1.141',
      5432,
      'tesidb',
      username: 'admin',
      password: 'admin',
    );

    await connection.open();

    var query = 'SELECT * FROM public.nightlife ORDER BY id ASC ';

    List<List<dynamic>> results = await connection.query(query);

    var latitudine, longitudine, clubName, clubDesc, clubID;

    for (final row in results) {
      clubID = row[0];
      clubName = row[1];
      clubDesc = row[4];
      latitudine = row[5];
      longitudine = row[6];
    }
    print("$clubID $clubName $clubDesc $latitudine $longitudine");

    _addMarkers(latitudine, longitudine, clubName, clubDesc, clubID);
  }

  void _addMarkers(latitude, longitude, clubName, clubDesc, clubID) {
    LatLng _nightClubPosition = LatLng(latitude, longitude);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_nightClubPosition.toString()),
        position: _nightClubPosition,
        infoWindow: InfoWindow(
          title: clubName,
          snippet: clubDesc,
          onTap: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NightClubProfile(
                          documentID: clubID,
                        )));*/
          },
        ),
        icon: BitmapDescriptor.defaultMarker,
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
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(children: <Widget>[
          googleMapsCreation(),
          Align(
            alignment: Alignment.topRight, // aligne les widget en haut à gauche
            child: Column(
              children: <Widget>[
                SizedBox(height: 3), // sépare distance entre bouton
                FloatingActionButton(
                  //premier bouton qui recentre la position selon _center centre de paris
                  onPressed: _userPosition,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.center_focus_weak,
                    size: 35,
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
}
