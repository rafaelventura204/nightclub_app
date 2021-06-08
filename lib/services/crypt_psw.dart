import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class CryptPsw {
  PlatformStringCryptor cryptor;
  var key = "null";
  String encryptedS, decryptedS;
  var pass = "null";

  Encrypt(String password) async {
    cryptor = PlatformStringCryptor();
    final salt = await cryptor.generateSalt();

    pass = password.toString();

    key = await cryptor.generateKeyFromPassword(pass, salt);

    encryptedS = await cryptor.encrypt(pass, key);

//    print("->$encryptedS");

    return encryptedS.toString();
  }

  void Decrypt(String password) async {
    try {
      decryptedS = await cryptor.decrypt(encryptedS, key);

      print("$decryptedS <-");
    } on MacMismatchException {}
  }
}
