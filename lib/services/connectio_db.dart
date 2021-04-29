import 'package:postgres/postgres.dart';

class ConnectionDb {
  connectDb() {
    // db connection
    var connection = PostgreSQLConnection(
      '159.149.181.251',
      5432,
      'tesidb',
      username: 'admin',
      password: 'admin',
    );

    return connection;
  }
}
