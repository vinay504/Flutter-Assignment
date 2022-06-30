
import 'package:assignment_flutter/constants/app_constants.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';

import '../model/validation_item.dart';
import '../widgets/utils.dart';

class EncryptionProvider extends ChangeNotifier{
  var encryptedText;


  //used static key for encryption and decryption. Tried with input from textfield having some issues need some more time to look into
   static String secretAESKey = 'qwertyuioplkjhgfdsazxcvbnmkloiuy';
   static final randomAESIv = utils.CreateCryptoRandomString();
   static final key =  Key.fromUtf8( secretAESKey);
   final iv = IV.fromBase64(randomAESIv);
   final encrypter = encrypt.Encrypter(encrypt.AES(key));



   ValidationItem _tfMessage = ValidationItem(null,null);
   ValidationItem _tfSecretKey = ValidationItem(null,null);
   //Getters
   ValidationItem get tfMessage => _tfMessage;
   ValidationItem get tfSecretKey => _tfSecretKey;


    encrpytAES(text){
    final encrypted = encrypter.encrypt(text, iv: iv);
    print("randomAESstring generated $secretAESKey");
    print("randomAESstring generated $randomAESIv");
    print("base16 key ${key.base16}");
    print("base64 key ${key.base64}");
    print("$encrypter");
    return encrypted;

  }

    decrpytAES(text){
    print("randomAESstring generated $secretAESKey");
    print("randomAESstring generated $randomAESIv");
    print("base16 key ${key.base16}");
    print("base64 key ${key.base64}");
    return encrypter.decrypt(text, iv: iv);
  }

  bool get isValid {
   if (_tfSecretKey.value != null && _tfMessage.value != null){
    return true;
   } else {
    return false;
   }
  }

  //Setters
  void validateMessageField(String value){
   if (value.length >= 3){
    _tfMessage=ValidationItem(value,null);
   } else {
    _tfMessage=ValidationItem(null, "Must be at least 3 characters");
   }
   notifyListeners();
  }

  void validateKeyField(String value){
   if (value.length >= 31){
    _tfSecretKey=ValidationItem(value,null);
    AppConstants.secretKey = '${_tfSecretKey.value}';
    print('appConstant:::::: ${AppConstants.secretKey}');
   } else {
    _tfSecretKey=ValidationItem(null, "Must be 32 characters only");
   }
   // AppConstants.secretKey = '${_tfSecretKey.value}';
   print('Length ${secretAESKey.length} - '+secretAESKey);

   notifyListeners();
  }



  void encryptData(){
    encryptedText = encrpytAES(tfMessage.value);
   print("encryptData = ${encryptedText.base64}");
    print('Length ${secretAESKey.length} - '+secretAESKey);
    notifyListeners();
  }

  void decryptData(){
    encryptedText = decrpytAES(encryptedText);
    print("decryptData = $encryptedText");
    notifyListeners();
  }

}
