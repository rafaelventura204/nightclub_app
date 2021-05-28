import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// class MyMapPolyline extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Locali Intrattenimento',
//       home: MyMapPolylinePage(title: 'Cerca'),
//     );
//   }
// }

class MyMapPolylinePage extends StatefulWidget {
  final double latitudineNightlife, longitudineNightlife;

  MyMapPolylinePage(
      {Key key,
      @required this.latitudineNightlife,
      @required this.longitudineNightlife})
      : super(key: key);

  @override
  _MyMapPolylinePageState createState() => _MyMapPolylinePageState();
}

class _MyMapPolylinePageState extends State<MyMapPolylinePage> {
  /*POSIZIONE ATTUALE*/
  bool mapToggle = false;
  var currentLocation;

  /*Posizione destinazione*/
  //final double _destinationlatitude = widget.latitudineNightlife;
  //final double _destinationlongitude = widget.longitudineNightlife;

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
      LatLng(widget.latitudineNightlife, widget.longitudineNightlife),
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
        title: Text('DOVE siamo'),
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
                            target: LatLng(_originelatitude, _originlongitude),
                            // LatLng(currentLocation.latitude,
                            //     currentLocation.longitude),
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
      PointLatLng(widget.latitudineNightlife, widget.longitudineNightlife),
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
