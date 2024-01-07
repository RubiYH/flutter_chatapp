import 'dart:convert';
import 'package:flutter_chatapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getListFromPrefs(String storage, Function addToListFn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString(storage) == null) {
    prefs.setString(storage, '[]').then(
        (value) => print("Created new prefs since it's missing: $storage"));
    return;
  }

  final getPrefs = prefs.getString(storage);

  if (getPrefs != null) {
    final decode = jsonDecode(getPrefs);
    if (decode is List) {
      for (final item in decode) {
        addToListFn(item);
      }
    }
  }
}
