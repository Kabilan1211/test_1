// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

//This file is used to define the  model of the database data format in the blocked user collection

validUser validUserFromJson(String str) => validUser.fromJson(json.decode(str));

String validUserToJson(validUser data) => json.encode(data.toJson());

class validUser {
    ObjectId id;
    String firstName;
    String lastName;
    String email;
    String password;
    int valid_User;

    validUser({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.valid_User,
    });

    factory validUser.fromJson(Map<String, dynamic> json) => validUser(
        id: json["id"],
        firstName: json["first name"],
        lastName: json["last name"],
        email: json["Email"],
        password: json["Password"],
        valid_User: json["Valid User"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first name": firstName,
        "last name": lastName,
        "Email": email,
        "Password": password,
        "Valid User": valid_User,
    };
}

