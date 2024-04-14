import 'package:encrypt/encrypt.dart';

import '../index.dart';

class DataHelper {
  DataHelper._();

  static String decrypt(String data) {
    try {
      final key = Key.fromBase64(EnvConstants.secretkey);
      final iv = IV.fromBase64(EnvConstants.secretIV);
      final e = Encrypter(AES(key, mode: AESMode.cbc));
      final result = e.decrypt(Encrypted.fromBase64(data), iv: iv);
      Log.d('decrypt:\n$result');
      return result;
    } catch (e) {
      Log.e('decrypt: $e');
    }
    return '';
  }

  static String encrypt(String data) {
    try {
      final key = Key.fromBase64(EnvConstants.secretkey);
      final iv = IV.fromBase64(EnvConstants.secretIV);
      final e = Encrypter(AES(key, mode: AESMode.cbc));
      final result = e.encrypt(data, iv: iv);
      Log.d('encrypt:\n${result.base64}');
      return result.base64;
    } catch (e) {
      Log.e('encrypt: $e');
    }
    return '';
  }

  // static String sha256Encrypted({required String abc}) {
  //   final bytes1 = utf8.encode(abc); // data being hashed
  //   final digest1 = sha256.convert(bytes1); // Hashing Process
  //   return digest1.toString(); // Print After Hashing
  // }
}
