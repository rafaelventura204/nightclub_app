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

  @override
  Widget build(BuildContext context) {
    placeAllMarkers();
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          googleMapsCreation(),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _userPosition,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.gps_fixed,
                    size: 35,
                    color: Color(0xFF7854d3),
                  ),
                ),
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
