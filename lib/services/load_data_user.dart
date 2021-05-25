import 'package:bar_pub/models/category.dart';
import 'package:bar_pub/models/nightlife.dart';
import 'package:bar_pub/services/db_connection.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/queries.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:postgres/postgres.dart';

final List<Category> defaultListCategory = List<Category>();
final List<Nightlife> defaultListNightlife = List<Nightlife>();
final List<String> listUserCategory = List<String>();
Queries queries = Queries();

class LoadDataUser {
  GlobalPreferences gPref = GlobalPreferences();

  loadData() {
    if (finalName != null) {
      getCategoriesFromDB();
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

    for (var item in resultQuery) {
      defaultListNightlife.add(Nightlife(
          id: item[0],
          name: item[1],
          city: item[2],
          address: item[3],
          description: item[4],
          latitudine: item[5],
          longitutidine: item[6],
          urlImage: item[7],
          hour: item[8]));
    }
  }
}
