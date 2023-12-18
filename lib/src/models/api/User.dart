

import 'package:flutter_dashboard/src/models/api/BaseModel.dart';

class User extends BaseModel{
  late String id;
  late String userName;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String role;
  late String profile;
  late bool active;
  late DateTime createdAt;

  @override
  User.fromJson(Map<String, dynamic> data) {
    id =  data["id"] ?? "";
    userName = data["userName"]?? "";
    firstName = data["firstName"]?? "";
    lastName = data["lastName"] ?? "";
    email = data["email"]?? "";
    password = data["password"] ?? "";
    role = data["role"] ?? "Admin";
    profile = data["profile"] ?? "";
    active = data["active"] ?? false;
    createdAt = DateTime.parse(data["createdAt"]) ?? DateTime.now();
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "role": role,
    "profile": profile,
    "active": active,
    "createdAt": createdAt.toUtc().toIso8601String(),
  };


}