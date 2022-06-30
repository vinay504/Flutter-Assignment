
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

mixin utils {
  //AES 256 bit key
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 16]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  static void showSnackBar(BuildContext context, String text) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));
}