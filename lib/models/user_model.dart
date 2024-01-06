class UserModel {
  final String id;
  String username;
  String? nickname, avatarURL, lastChatAt, memo;

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        id = json["id"],
        nickname = json["nickname"],
        avatarURL = json["avatarURL"],
        lastChatAt = json["lastChatAt"],
        memo = json["memo"];

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'nickname': nickname,
        'avatarURL': avatarURL,
        'lastChatAt': lastChatAt,
        "memo": memo,
      };
}
