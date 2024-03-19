// To parse this JSON data, do

// ignore_for_file: file_names

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String title;
    String body;

    NotificationModel({
        required this.title,
        required this.body,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        title: json["Title"],
        body: json["Body"],
    );

    Map<String, dynamic> toJson() => {
        "Title": title,
        "Body": body,
    };
}
