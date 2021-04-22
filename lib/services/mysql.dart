import 'dart:async';
import 'package:mysql1/mysql1.dart';

class MySql {
  String host = 'localhost',
      user = 'admin',
      password = 'Rafael24',
      db = 'dbTesi';
  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    return await MySqlConnection.connect(settings);
  }
}
