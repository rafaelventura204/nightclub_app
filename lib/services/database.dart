import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uId;
  DatabaseService({this.uId});

  /*collection reference 
  -> crea una "tabella" 
  -> per ogni nuovo utente crea un nuovo record
  */
  final CollectionReference usersRecords =
      FirebaseFirestore.instance.collection('User');
  Future updateUsers(String username, int idCategory, String idPub) async {
    return await usersRecords
        .doc(uId)
        .set({'Username': username, 'IdCategory': idCategory, 'IdPub': idPub});
  }
}
