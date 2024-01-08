import 'dart:convert';
import 'package:flutter_chatapp/models/user_memo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getListFromPrefs(String storage, Function addToListFn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // prefs.setString("Chats",
  //     '[{"username":"John","id":"1234","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastMessage":null,"rawlastChatAt":null,"lastChatAt":null,"unreads":2},{"username":"Sam","id":"4321","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastMessage":null,"rawlastChatAt":"2024-01-05 19:22:03Z","lastChatAt":" 1 min ago","unreads":0},{"username":"John","id":"9823409545454458234098234098","avatarURL":"https://lh3.google.com/u/0/ogw/ANLem4YhMQ9VVephNQ0m4A_jRJxxeSkSKYCi7ELdJ6-R=s32-c-mo","lastMessage":"Hellooooooooooooooooooooiroweriweoiweoirweoirowerworiweoiwoiworiwirwirwoirweiriweriweoriweriweirweiorwioierwoo","rawlastChatAt":"2023-03-05 12:36:45Z","lastChatAt":"2 mins ago","unreads":12}]');

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
