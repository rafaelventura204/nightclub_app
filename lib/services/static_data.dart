import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/screens/home/home_screen.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:geolocator/geolocator.dart';

class StaticData {
  static final List<Property> properties = List<Property>();

  addNightlife() {
    for (int i = 0; i < defaultListNightlife.length; i++) {
      properties.add(Property(
        id: defaultListNightlife.elementAt(i).id,
        name: defaultListNightlife.elementAt(i).name,
        description: defaultListNightlife.elementAt(i).description,
        imagePath: defaultListNightlife.elementAt(i).urlImage.toString(),
        hour: getDayOfWeek(i), //set-orario
        distance: getDistance(i),
        address: defaultListNightlife.elementAt(i).address.toString(),
        latitudine: defaultListNightlife.elementAt(i).latitudine,
        longitudine: defaultListNightlife.elementAt(i).longitutidine,
      ));
      //properties.sort((a, b) => a.distance.compareTo(b.distance));
    }
  }

  String getDayOfWeek(int index) {
    DateTime date = DateTime.now(); //return the of week, start with Monday=1
    int numDay = date.weekday;
    --numDay;
    List<String> tempOrari = defaultListNightlife.elementAt(index).hour;
    return tempOrari.elementAt(numDay);
  }

  String getDistance(int index) {
    var destLatitu = defaultListNightlife.elementAt(index).latitudine;
    var destLongi = defaultListNightlife.elementAt(index).longitutidine;

    final double distanceInMeters = Geolocator.distanceBetween(
        myLatitudine, myLongitudine, destLatitu, destLongi);

    return (distanceInMeters / 1000.0).toStringAsFixed(1);
  }

  List<Property> getProperties() {
    return properties;
  }

  // preferencesNightlife() {
  //   //listUserCategory.length;
  // }
}

/*Property(
      name: 'Aramani',
      description: "Luogo bellissimo dove passare un buon momento con amici",
      price: "20:20",
      imagePath: "assets/images/profiloProva.png",
    ),
    Property(
      name: "La Fontanella",
      description:
          "Se stai cercando un posto al centro della movida milanese Le Fontanelle è il posto per te",
      price: "19.20",
      imagePath: "assets/images/profiloProva.png",
    ),*/
