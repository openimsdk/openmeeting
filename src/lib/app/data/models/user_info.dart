import 'dart:convert';

class UserInfo {
  final String token;
  final String userId;
  final String nickname;
  final String? faceURL;

  UserInfo({required this.token, required this.userId, required this.nickname, this.faceURL});

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        token: json["token"] ?? '',
        userId: json["userID"],
        nickname: json["nickname"],
        faceURL: json["faceURL"],
      );

  Map<String, dynamic> toMap() => {"token": token, "userID": userId, "nickname": nickname, 'faceURL': faceURL};
}
