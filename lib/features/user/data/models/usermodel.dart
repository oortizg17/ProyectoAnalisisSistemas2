import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

// ignore: must_be_immutable
class User extends Equatable {
  User({
    this.page,
    this.perPage,
    @required this.total,
    @required this.totalPages,
    @required this.data,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserInfo> data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data:
            List<UserInfo>.from(json["data"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        User(
            page: page,
            perPage: perPage,
            total: total,
            totalPages: totalPages,
            data: data)
      ];
}

// ignore: must_be_immutable
class UserInfo extends Equatable {
  UserInfo({
    @required this.id,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };

  @override
  List<Object> get props => [
        UserInfo(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            avatar: avatar)
      ];
}
