import 'package:bar_pub/models/user.dart';
import 'package:postgres/postgres.dart';

/* 
UNI:159.149.181.251
CASA:192.168.1.141
*/

class AuthService {
  //user
  MyUser user;
  //ConnectionDb conDb;

  // register with EmailandPassword
  Future registerWithEmailPassword(String email, String password) async {
    var connection = PostgreSQLConnection(
      '192.168.1.141',
      5432,
      'tesidb',
      username: 'admin',
      password: 'admin',
    );

    await connection.open();

    var query =
        'INSERT INTO public."User"( "Username", "Password") VALUES (@email, @psw);';
    var results = await connection.query(query,
        substitutionValues: {
          'email': email,
          'psw': password,
        },
        timeoutInSeconds: 240);
    var test = results.affectedRowCount == 1;
    print(test.toString());
    print("UTENTE REGISTRATO [AUTHSERVICE]");
  }

  //sign in wiht email & password
  Future signInWithEmailPassword(String email, String password) async {
    //SELEZIONA ELEMENTO DAL DB E FAI CHECK

    var connection = PostgreSQLConnection(
      '192.168.1.141',
      5432,
      'tesidb',
      username: 'admin',
      password: 'admin',
    );

    await connection.open();

    var query =
        'SELECT "Username" FROM public."User" WHERE "Username" = @email';

    List<List<dynamic>> results =
        await connection.query(query, substitutionValues: {'email': email});

    var utente;
    for (final row in results) {
      utente = row[0];
      print(utente.toString());
    }

    return utente;
  }

  //sign out
  Future signOut() async {
    /*try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }*/
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


  }*/
