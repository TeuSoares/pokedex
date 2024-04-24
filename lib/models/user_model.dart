class UserModel {
  int? id;
  String? nickname;
  String? avatar;
  String? password;

  UserModel({
    this.id,
    this.nickname,
    this.avatar,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'avatar': avatar,
        'password': password,
      };
}
