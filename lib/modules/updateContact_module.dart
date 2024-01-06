import 'dart:convert';

import 'package:flutter_chatapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future updateContact(List<UserModel> ContactsList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final newList = ContactsList.toList();

  newList.sort(
    (a, b) {
      return a.username.compareTo(b.username);
    },
  );

  var encoded = jsonEncode(newList);

  prefs.setString("Contacts", encoded);
}
