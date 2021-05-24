import 'package:bar_pub/services/db_connection.dart';
import 'package:bar_pub/services/queries.dart';
import 'package:postgres/postgres.dart';

class AuthService {
  PostgreSQLConnection connection;
  Queries queries = Queries();

  // register with EmailandPassword
  Future registerWithEmailPassword(String email, String password) async {
    connection = await DBconnect.connect;

    var results = await connection.query(queries.registerUserQuery(),
        substitutionValues: {
          'email': email,
          'psw': password,
        },
        timeoutInSeconds: 240);
    var test = results.affectedRowCount == 1;
    print("${test.toString()} [AUTH1]");
  }

  //sign in wiht email & password
  Future signInWithEmailPassword(String email, String password) async {
    connection = await DBconnect.connect;

    List<List<dynamic>> results = await connection
        .query(queries.loginUserQuery(), substitutionValues: {'email': email});

    var utente;
    for (final row in results) {
      utente = row[0];
      print("${utente.toString()} [AUTH2]");
    }

    return utente;
  }
}

/*final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object base on FirebaseUser
  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uId: user.uid, nameUser: user.email) : null;
  }

  //auth change user stream ->ogni utente lo mappa nel mio tipo di utente
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in wiht email & password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register in wiht email & password
  Future registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //crea un nuovo record per l'attuale user registrato
      await DatabaseService(uId: user.uid).updateUsers(user.email, 0, '');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  /*Future signOut() async {
    /*try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }*/
  }*/

  }*/
