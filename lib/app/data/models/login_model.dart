// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  List<String>? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toJson(),
  };
}

class Data {
  String? token;
  LoginUser? user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: json["user"] == null ? null : LoginUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class LoginUser {
  int? id;
  String? name;
  String? email;
  String? image;
  String? phone;
  String? gender;
  String? country;
  bool? status;

  LoginUser({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.gender,
    this.country,
    this.status,
  });

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    phone: json["phone"],
    gender: json["gender"],
    country: json["country"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "phone": phone,
    "gender": gender,
    "country": country,
    "status": status,
  };
}
