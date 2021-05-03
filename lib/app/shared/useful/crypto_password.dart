import 'dart:convert';

import 'package:crypto/crypto.dart';

String convertPassaword(value) {
  var bytes = utf8.encode('$value');
  var disget = sha1.convert(bytes);
  return disget.toString();
}
