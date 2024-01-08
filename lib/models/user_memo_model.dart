class UserMemoModel {
  final String id, username;
  String? nickname, memo;

  UserMemoModel.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        id = json["id"],
        nickname = json["nickname"],
        memo = json["memo"];

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'nickname': nickname,
        "memo": memo,
      };
}
