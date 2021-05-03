import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
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

  /*Posizione destinazione*/
  double _destinationlatitude = 45.46477482199611;
  double _destinationlongitude = 9.192055246020525;

  /*Posizione origine*/
  double _originelatitude = 45.42578603176514;
  double _originlongitude = 9.20251086235185;

  /*Marker*/
  Map<MarkerId, Marker> markers = {};

  /*POLYLINE*/
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  /* Google map controller*/
  Completer<GoogleMapController> _controller = Completer();

  //Set di coordinalte
  //List<LatLng> routeCoords;

  void initState() {
    /*Set della posizione attuale attraverso la geolocalizzazione*/
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });

    _addMarker(
      LatLng(_originelatitude, _originlongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    _addMarker(
      LatLng(_destinationlatitude, _destinationlongitude),
      "destination",
      BitmapDescriptor.defaultMarker,
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
      color: Colors.purple[300],
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDlitorRQ9IutFGY-WZCWu65PmjHdpqD8U",
      PointLatLng(_originelatitude, _originlongitude),
      PointLatLng(_destinationlatitude, _destinationlongitude),
      travelMode: TravelMode.driving,
    );
    print("${currentLocation.latitude}POSIZIONE");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
