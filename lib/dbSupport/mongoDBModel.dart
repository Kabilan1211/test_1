// ignore_for_file: file_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

//This file is used to define the  model of the database data format in the user collection

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  ObjectId id;
  String firstName;
  String lastName;
  String email;
  String password;
  int reset;

  MongoDbModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.reset,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["id"],
        firstName: json["first name"],
        lastName: json["last name"],
        email: json["Email"],
        password: json["Password"],
        reset: json["Reset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first name": firstName,
        "last name": lastName,
        "Email": email,
        "Password": password,
        "Reset": reset,
      };
}
