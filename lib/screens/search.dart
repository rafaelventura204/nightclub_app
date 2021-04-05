import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:permission/permission.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locali Intrattenimento',
      home: MySearchPage(title: 'Cerca'),
    );
  }
}

class MySearchPage extends StatefulWidget {
  MySearchPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  /*POSIZIONE ATTUALE*/
  bool mapToggle = false;
  var currentLocation;
  //GoogleMapController mapController;

  /*Posizione destinazione*/
  double _destinationlatitude = 45.46477482199611;
  double _destinationlongitude = 9.192055246020525;

  /*Posizione origine*/
  double _originelatitude = 45.42578603176514;
  double _originelongitude = 9.20251086235185;

  /*marker*/
  Map<MarkerId, Marker> markers = {};

  /*POLYLINE*/
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  /* Google map controller*/
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();

  /*POLYLINE */
  //final Set<Polyline> polyline = {};
  //Set di coordinalte
  List<LatLng> routeCoords;
  /*GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDlitorRQ9IutFGY-WZCWu65PmjHdpqD8U");*/

  /*getSomePoints() async {
    var permissions =
        await Permission.getPermissionsStatus([PermissionName.Location]);
    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
      var askpermission =
          await Permission.requestPermissions([PermissionName.Location]);
    } else {
      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(currentLocation.latitude, currentLocation.longitude),
          destination: LatLng(45.432083533092786, 9.19928841039524),
          mode: RouteMode.driving);
    }
  }*/

  void initState() {
    //super.initState();
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });

    /*//getSomePoints();*/
    _addMarker(
      LatLng(_originelatitude, _originelongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destinationlatitude, _destinationlongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CERCA LOCALI'),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 141.0,
                width: double.infinity,
                child: mapToggle
                    ? GoogleMap(
                        /*onMapCreated: onMapCreated,
                        //polylines: polyline,
                        initialCameraPosition: CameraPosition(
                            //NEL TARGET è possibile passare un punto diverso
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 15.0),
                        mapType: MapType.normal,*/
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 15.0),
                        myLocationEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        polylines: Set<Polyline>.of(polylines.values),
                        markers: Set<Marker>.of(markers.values),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      )
                    : Center(
                        child: Text(
                        'Caricamento in corso...',
                        style: TextStyle(fontSize: 20.0),
                      )),
              )
            ],
          )
        ],
      ),
    );
  }

/*Serve per aggiungere il marker in base alla latitude e longitudine */
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDlitorRQ9IutFGY-WZCWu65PmjHdpqD8U",
      PointLatLng(_originelatitude, _originelongitude),
      PointLatLng(_destinationlatitude, _destinationlongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  /*void onMapCreated(controller) {
    setState(() {
      mapController = controller;

      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.purple[300],
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }*/
}
