class UsersListModel {
  final String id;
  String username;
  String? nickname, avatarURL, lastChatAt, addedAt;

  UsersListModel.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        id = json["id"],
        nickname = json["nickname"],
        avatarURL = json["avatarURL"],
        lastChatAt = json["lastChatAt"],
        addedAt = json["addedAt"];

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'nickname': nickname,
        'avatarURL': avatarURL,
        'lastChatAt': lastChatAt,
        "addedAt": addedAt
      };
}
