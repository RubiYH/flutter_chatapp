import 'dart:async';
import 'dart:convert';
import 'package:flutter_chatapp/models/user_list_model.dart';
import 'package:flutter_chatapp/modules/getListFromPrefs_module.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> addUserByID(String ID) async {
  // TODO rest api

  final response = await http.get(
    Uri.parse('http://localhost:3000/api/user/$ID'),
  );

  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // if already exists
    bool isExists = false;
    await getListFromPrefs("Users", (item) {
      if (UsersListModel.fromJson(item).id == ID) {
        isExists = true;
      }
    });

    if (isExists) {
      return {
        "status": "alreadyExists",
        "id": jsonResponse?["id"],
        "username": jsonResponse?["name"]
      };
    } else {
      return {
        "status": true,
        "id": jsonResponse?["id"],
        "username": jsonResponse?["name"],
        "avatarURL":
            "https://ui-avatars.com/api/?background=0D8ABC&color=fff&name=${jsonResponse?["name"]}&size=150"
      };
    }
  } else {
    return {
      ...jsonResponse,
      "status": false,
    };
  }
}
