import 'dart:convert';
import 'package:flutter_chatapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getContact(List<UserModel> ContactsList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // prefs
  //     .setString("Contacts",
  //         '[{"username":"John","id":"1234","nickname":"Johnny","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastChatAt":null},{"username":"Michael","id":"2345","nickname":"Mi","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastChatAt":"1 min ago","memo":"test memo"},{"username":"Joy","id":"4567","nickname":"Jojo","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastChatAt":"10 days ago","memo":null}]')
  //     .then((value) => print("done"));

  final contacts = prefs.getString("Contacts");

  if (contacts != null) {
    final decode = jsonDecode(contacts);
    if (decode is List) {
      for (final e in decode) {
        ContactsList.add(UserModel.fromJson(e));
      }
    }
  }
}
