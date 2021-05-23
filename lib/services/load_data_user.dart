import 'package:bar_pub/models/category.dart';
import 'package:bar_pub/services/db_connection.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/queries.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:postgres/postgres.dart';

final List<Category> defaultListCategory = List<Category>();
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
      print(a);
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
    print("{$nameUser - $nameCategory} <= valori passati");

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
}
