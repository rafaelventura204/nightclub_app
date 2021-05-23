import 'package:postgres/postgres.dart';

class DBconnect {
  static PostgreSQLConnection _connection;

  // connessione DB
  static Future<PostgreSQLConnection> get connect => _connect();

  static Future<PostgreSQLConnection> _connect() async {
    if (_connection == null || _connection.isClosed) {
      _connection = PostgreSQLConnection(
        '192.168.1.141',
        5432,
        'tesidb',
        username: 'admin',
        password: 'admin',
      );
      await _connection.open();
    }

    return _connection;
  }

  static terminate() {
    if (_connection != null) {
      _connection.close();
      _connection = null;
    }
  }
}
