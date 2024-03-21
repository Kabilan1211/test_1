// To parse this JSON data, do

// ignore_for_file: file_names

import 'dart:convert';

//It is the Notification format, that should be in the database

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String title;
    String body;
    int notificationNumber;

    NotificationModel({
        required this.title,
        required this.body,
        required this.notificationNumber
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        title: json["Title"],
        body: json["Body"],
        notificationNumber: json["Notification Number"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "Body": body,
        "Notification Number": notificationNumber,
    };
}
