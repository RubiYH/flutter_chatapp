import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future updateListToPrefs(String storage, List targetList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final newList = targetList.toList();

  var encoded = jsonEncode(newList);

  prefs.setString(storage, encoded);
}
