import 'package:bar_pub/models/category.dart';
import 'package:bar_pub/models/nightlife.dart';
import 'package:bar_pub/models/property.dart';
import 'package:bar_pub/services/db_connection.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/queries.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:postgres/postgres.dart';

final List<Category> defaultListCategory = List<Category>();
final List<Nightlife> defaultListNightlife = List<Nightlife>();
final List<String> listUserCategory = List<String>();
final List<Nightlife> myListNightlifes = List<Nightlife>();
final List<Property> viewNightlife = List<Property>();
Queries queries = Queries();

class LoadDataUser {
  GlobalPreferences gPref = GlobalPreferences();

  loadData() {
    if (finalName != null) {
      getCategoriesFromDB();
      getNightlifeFromDB();
      getUserCategoryFromDB(finalName);
    }
  }

  Future getCategoriesFromDB() async {
    PostgreSQLConnection connection = await DBconnect.connect;

    List<PostgreSQLResultRow> resultQuery =
        (await connection.query(queries.getCategoryQuery())).toList();

    resultQuery.sort((a, b) {
      var aMap = a.asMap();
      var bMap = b.asMap();
      return aMap[1].compareTo(bMap[1]);
    });

    Map<int, PostgreSQLResultRow> results = resultQuery.asMap();
    for (int row in results.keys) {
      defaultListCategory.add(
          Category(idCategory: results[row][0], nameCategory: results[row][1]));
    }
  }

  Future loadUserCategoryToDB(String idUser, int idCategory) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    var results =
        await connection.query(queries.loadUserCatQuery(), substitutionValues: {
      'idUser': idUser,
      'idCatgory': idCategory,
    });
    if (results.affectedRowCount == 1)
      print("Inserted user: SUCCESS!");
    else
      print("Inserted user: FAILED!");
  }

  Future getUserCategoryFromDB(String idUser) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    List<PostgreSQLResultRow> resultQuery = (await connection.query(
            queries.getUserCategoryQuery(),
            substitutionValues: {'idUser': idUser}))
        .toList();

    for (int i = 0; i < resultQuery.length; i++) {
      var tempValue = resultQuery.elementAt(i).toString();
      if (!listUserCategory.contains(tempValue)) {
        listUserCategory.add(tempValue);
      }
    }
  }

  Future removeUserCategoryFromDB(String nameUser, String nameCategory) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    nameCategory = nameCategory.replaceAll("[", "").replaceAll("]", "");

    var results = await connection
        .query(queries.removeUserCategoryQuery(), substitutionValues: {
      'idUser': nameUser,
      'idCategory': nameCategory,
    });
    if (results.affectedRowCount == 1)
      print("remove category: SUCCESS!");
    else
      print("remove category: FAILED!");
  }

  Future getNightlifeFromDB() async {
    PostgreSQLConnection connection = await DBconnect.connect;

    List<PostgreSQLResultRow> resultQuery =
        (await connection.query(queries.getNightlifeQuery())).toList();

    if (resultQuery.length > defaultListNightlife.length) {
      for (var item in resultQuery) {
        defaultListNightlife.add(
          Nightlife(
            id: item[0],
            name: item[1],
            city: item[2],
            address: item[3],
            description: item[4],
            latitudine: item[5],
            longitutidine: item[6],
            urlImage: item[7],
            hour: item[8],
            categories: await getNightCatFromDB(item[0]) as List,
          ),
        );
      }
    }
  }

  Future loadUserNightlifeToDB(String idUser, int idNightlife) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    var results = await connection
        .query(queries.loadUserNightlifeQuery(), substitutionValues: {
      'idUser': idUser,
      'idNightlife': idNightlife,
    });

    if (results.affectedRowCount == 1)
      print("Inserted nightlife user: SUCCESS!");
    else
      print("Inserted nightlife user: FAILED!");
  }

  Future removeUserNightlifeFromDB(String idUser, int idNightlife) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    var results = await connection
        .query(queries.removeUserNightlifeQuery(), substitutionValues: {
      'idUser': idUser,
      'idNightlife': idNightlife,
    });

    if (results.affectedRowCount == 1)
      print("remvoe nightlife user: SUCCESS!");
    else
      print("remove nightlife user: FAILED!");
  }

  Future getNightCatFromDB(int idNightlife) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    List<String> tmp = List<String>();
    List<PostgreSQLResultRow> resultQuery = (await connection.query(
            queries.getNightlifeCategoryQuery(),
            substitutionValues: {'idNightlife': idNightlife}))
        .toList();

    for (var item in resultQuery) {
      tmp.add(item.toString());
    }

    return tmp;
  }

  Future getUserNightlifeFromDB(String idUser) async {
    PostgreSQLConnection connection = await DBconnect.connect;

    List<PostgreSQLResultRow> resultQuery = (await connection.query(
            queries.getUserNightlifeQuery(),
            substitutionValues: {'idUser': idUser}))
        .toList();

    if (resultQuery.length > viewNightlife.length) {
      viewNightlife.clear();
      List<String> tmpLocali = List<String>();
      for (var item in resultQuery) {
        tmpLocali.add(item.toString().replaceAll('[', '').replaceAll(']', ''));
      }

      for (int i = 0; i < tmpLocali.length; i++) {
        int idlocale = int.parse(tmpLocali.elementAt(i));
        for (int j = 0; j < defaultListNightlife.length; j++) {
          if (defaultListNightlife.elementAt(j).id == idlocale) {
            viewNightlife.add(Property(
              id: defaultListNightlife.elementAt(j).id,
              name: defaultListNightlife.elementAt(j).name,
              imagePath: defaultListNightlife.elementAt(j).urlImage,
              address: defaultListNightlife.elementAt(j).address,
              categories: defaultListNightlife.elementAt(j).categories,
              description: defaultListNightlife.elementAt(j).description,
              latitudine: defaultListNightlife.elementAt(j).latitudine,
              longitudine: defaultListNightlife.elementAt(j).longitutidine,
            ));
          }
        }
      }
    }
  }
}//closed-class
