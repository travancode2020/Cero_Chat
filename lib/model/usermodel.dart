import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
UserModel myUserModel = UserModel();

class UserModel {
  var userName;
  List<dynamic>? followers;
  String? name;
  String? email;
  String? password;

  UserModel({
    this.userName,
    this.name,
    this.email,
    this.password,
    this.followers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        userName: json["userName"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() =>
      {
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "name": name,
        "email": email,
        "password": password,
        "userName": userName,
      };
}