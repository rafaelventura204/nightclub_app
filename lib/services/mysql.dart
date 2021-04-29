import 'dart:async';
import 'package:mysql1/mysql1.dart';

class MySql {
  String host = '159.149.181.251',
      user = 'root',
      password = 'secret',
      db = 'TESIDB';
  static int port = 6033;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    return await MySqlConnection.connect(settings);
  }
}
