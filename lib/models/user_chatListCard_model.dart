class UserChatListCardModel {
  final String id;
  String username;
  String? nickname, avatarURL, lastMessage, rawlastChatAt, lastChatAt;
  int unreads;

  UserChatListCardModel.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        id = json["id"],
        avatarURL = json["avatarURL"],
        lastMessage = json["lastMessage"],
        rawlastChatAt = json["rawlastChatAt"],
        lastChatAt = json["lastChatAt"],
        unreads = json["unreads"];

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'avatarURL': avatarURL,
        'lastMessage': lastMessage,
        'rawlastChatAt': rawlastChatAt,
        'lastChatAt': lastChatAt,
        'unreads': unreads
      };
}
