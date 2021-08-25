import 'dart:collection';

import 'package:bar_pub/models/property.dart';
/*import 'package:bar_pub/screens/home/home_screen.dart';
import 'package:bar_pub/screens/Guest/home_screen_Guest.dart';*/
import 'package:bar_pub/services/load_data_user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bar_pub/services/wrapper.dart';

class StaticData {
  static final List<Property> properties = List<Property>();
  final LoadDataUser loadDataUser = LoadDataUser();
  int prefAlgoritm = -1;

  addNightlife() {
    /*Algoritmo OSPITE */
    if (finalName == null) {
      //OSPITE
      //Ordinamento locali: Alfabetico!
      if (properties.length < defaultListNightlife.length) {
        for (int i = 0; i < defaultListNightlife.length; i++) {
          properties.add(Property(
            id: defaultListNightlife.elementAt(i).id,
            name: defaultListNightlife.elementAt(i).name,
            description: defaultListNightlife.elementAt(i).description,
            imagePath: defaultListNightlife.elementAt(i).urlImage.toString(),
            hour: getDayOfWeek(i), //set-orario
            distance: getDistance(i), //set-distance
            address: defaultListNightlife.elementAt(i).address.toString(),
            latitudine: defaultListNightlife.elementAt(i).latitudine,
            longitudine: defaultListNightlife.elementAt(i).longitutidine,
            categories: defaultListNightlife.elementAt(i).categories,
          ));
        }
      }
      properties.sort((a, b) => a.name.compareTo(b.name));
    } else {
      if (properties.length < defaultListNightlife.length) {
        for (int i = 0; i < defaultListNightlife.length; i++) {
          properties.add(Property(
            id: defaultListNightlife.elementAt(i).id,
            name: defaultListNightlife.elementAt(i).name,
            description: defaultListNightlife.elementAt(i).description,
            imagePath: defaultListNightlife.elementAt(i).urlImage.toString(),
            hour: getDayOfWeek(i), //set-orario
            distance: getDistance(i), //set-distance
            address: defaultListNightlife.elementAt(i).address.toString(),
            latitudine: defaultListNightlife.elementAt(i).latitudine,
            longitudine: defaultListNightlife.elementAt(i).longitutidine,
            categories: defaultListNightlife.elementAt(i).categories,
          ));
        }
      }
      preferencesNightlife();
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

  preferencesNightlife() {
    /*Algoritmo di ordinamento in base a:
        distance 1 
        numero di categorie -1
        neutro 0
      Utile per possibili implementazioni future, dove sarà l'utente stesso a
      decidere quale 'algoritmo' applicare
    */

    //NEUTRO
    if (prefAlgoritm == 0) {
      properties.sort((a, b) => a.distance.compareTo(b.distance));
      Map<String, int> totalCategories = Map<String, int>();
      List<String> B = listUserCategory;

      for (int i = 0; i < properties.length; i++) {
        List<String> A = properties.elementAt(i).categories;
        String tmpIdLocale = properties.elementAt(i).name;
        int c = calcMatchCategories(A, B);
        totalCategories[tmpIdLocale] = c;
      }

      var sortedKeys = totalCategories.keys.toList(growable: false)
        ..sort((k1, k2) => totalCategories[k2].compareTo(totalCategories[k1]));
      LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => totalCategories[k]);

      //Elenco ordinato dei locali con priorità
      Iterable<dynamic> set = sortedMap.keys;
      int sup = 0, inf = 0;

      //sistemazione array in base al numero di preferenze
      for (int i = 0; i < set.length; i++) {
        for (int j = 0; j < properties.length; j++) {
          //trova index massimo in properties
          if (set.elementAt(i) == properties.elementAt(j).name) {
            sup = j;
          }
        }
        swap(inf, sup);
        inf++;
      }
    } else if (prefAlgoritm == 1) {
      //DISTANCE
      properties.sort((a, b) => a.distance.compareTo(b.distance));
    } else {
      //L'algoritmo ordina prima in base alle categorie poi successivamente
      //in base alla distanza
      //#CATEGORIES
      Map<String, int> totalCategories = Map<String, int>();
      List<String> B = listUserCategory;

      for (int i = 0; i < properties.length; i++) {
        List<String> A = properties.elementAt(i).categories;
        String tmpIdLocale = properties.elementAt(i).name;
        int c = calcMatchCategories(A, B);
        totalCategories[tmpIdLocale] = c;
      }

      //Ordinamento dei locali in base al numero di preferenze
      //locali con almeno una categoria in comune con l'utente sarà nella parte
      //sinistra dell'array
      var sortedKeys = totalCategories.keys.toList(growable: false)
        ..sort((k1, k2) => totalCategories[k2].compareTo(totalCategories[k1]));
      LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => totalCategories[k]);

      //Elenco ordinato dei locali con priorità
      Iterable<dynamic> set = sortedMap.keys; //locali con almeno un match
      int sup = 0, inf = 0;

      //sistemazione array in base al numero di categorie.
      //Locali con maggior numero di categorie in comune saranno posizionati più
      //a sinistra, quindi sarà ordinato in ordine decrescente
      //modifica della lista originaria cercando il max
      for (int i = 0; i < set.length; i++) {
        for (int j = 0; j < properties.length; j++) {
          //trova index massimo in properties
          if (set.elementAt(i) == properties.elementAt(j).name) {
            sup = j;
          }
        }
        swap(inf, sup);
        inf++;
      }

      //applicare algoritmo distance sui locali con zero categorie in comune

      //primo index con zero categorie in comune
      var foundLst = sortedMap.values;
      int found;
      for (int i = 0; i < foundLst.length; i++) {
        if (foundLst.elementAt(i) == 0) {
          found = i;
          break;
        }
      }

      //ordina(in base alla distanza) solo una parte di array, cioè quella con
      // zero categorie in comuni
      //RISOLVERE PROBLEMA QUA
      if (foundLst.length > 0) sortSublist(found, properties.length);
    }
  }

  void sortSublist<Property>(int start, int end) {
    properties.setRange(
        start,
        end,
        properties.sublist(start, end)
          ..sort((a, b) => a.distance.compareTo(b.distance)));
  }

  swap(int inf, int sup) {
    var temp = properties[inf];
    properties[inf] = properties[sup];
    properties[sup] = temp;
  }

  int indexMax(String name, List<String> A) {
    return A.indexOf(name);
  }

  int calcMatchCategories(List<String> A, List<String> B) {
    var tmpMatch = A.where((element) => B.contains(element));

    return tmpMatch.length;
  }
}
