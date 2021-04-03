import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission/permission.dart';

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
  GoogleMapController mapController;

  /*POLYLINE */
  final Set<Polyline> polyline = {};
  //Set di coordinalte
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDlitorRQ9IutFGY-WZCWu65PmjHdpqD8U");

  getSomePoints() async {
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
  }

  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
    getSomePoints();
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
                        onMapCreated: onMapCreated,
                        polylines: polyline,
                        initialCameraPosition: CameraPosition(
                            //NEL TARGET è possibile passare un punto diverso
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 15.0),
                        mapType: MapType.normal,
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

  void onMapCreated(controller) {
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
  }
}
