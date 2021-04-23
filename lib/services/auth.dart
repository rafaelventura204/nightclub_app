import 'package:bar_pub/models/user.dart';
import 'package:bar_pub/services/database.dart';
import 'package:bar_pub/services/mysql.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  var db = new MySql();

  //register with EmailandPassword
  Future registerWithEmailPassword(String email, String password) async {
    db.getConnection().then((conn) {
      String insertUser =
          'insert into User (Username, Password, Disable) values (?, ?, ?)';
      conn.query(insertUser, [email, password, true]);
    });
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
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/
