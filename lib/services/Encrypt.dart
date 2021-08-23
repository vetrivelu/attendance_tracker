import 'package:encrypt/encrypt.dart';

class Encryptor {
  static var key = Key.fromUtf8('uqAaTfnfOCiI44kao92jLYQOPNJgDj');
  static var iv = IV.fromLength(8);


  static String encrypt(String plainText) {  
    var encrypter = Encrypter(Salsa20(key));
    var encrypted = encrypter.encrypt(plainText, iv: iv);
    print (encrypted.base64);
    return encrypted.base64;
  }

  static String decrypt(String plainText) {
    var encrypter = Encrypter(Salsa20(key));
    var decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);
    return decrypted;
  }
}