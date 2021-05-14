import 'package:bar_pub/services/db_connection.dart';
import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/queries.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:postgres/postgres.dart';

final List<String> listCategory = List<String>();

class LoadDataUser {
  GlobalPreferences gPref = GlobalPreferences();

  loadData() {
    if (finalName != null) {
      getCategoriesFromDB();
    }
  }

  Future getCategoriesFromDB() async {
    PostgreSQLConnection connection;
    DBconnect dBconnect = DBconnect();
    Queries queries = Queries();

    connection = await dBconnect.dbConnect();

    List<List<dynamic>> results =
        await connection.query(queries.getCategoryQuery());

    for (var row in results) {
      listCategory.add(row.toString());
    }

    listCategory.sort();
    listCategory.toString().replaceAll("[", "").replaceAll("]", "");
    for (int i = 0; i < listCategory.length; i++) {
      print(listCategory.elementAt(i));
    }
  }
}
