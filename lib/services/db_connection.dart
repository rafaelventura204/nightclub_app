import 'package:postgres/postgres.dart';

class DBconnect {
  // connessione DB
  Future<PostgreSQLConnection> dbConnect() async {
    var connection = PostgreSQLConnection(
      '159.149.181.251',
      5432,
      'tesidb',
      username: 'admin',
      password: 'admin',
    );

    await connection.open();
    return connection;
  }
}
