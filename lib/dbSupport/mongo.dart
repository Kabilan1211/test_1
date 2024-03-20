// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test_1/dbSupport/constants.dart';
import 'package:test_1/dbSupport/mongoDBModel.dart';
import 'package:test_1/dbSupport/notificationModel.dart';
import 'package:test_1/dbSupport/validUser.dart';

//This file contains all the function used to perform CRUD operation from the database

class MongoDatabase {
  static var db, userCollection, invalidUser, notificationCollection ;

  //Function used to connect the database
  static connect() async {
    db = await Db.create(mongoConnUrl);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_CONNECTION);
    invalidUser = db.collection(validity);
    notificationCollection = db.collection(Notification);
  }

  //Function used to update the Database 
  static Future<void> update(String password, String email) async {
    await userCollection.update(
        where.eq('Email', email), modify.set('Password', password));
    await userCollection.update(where.eq('Reset', 1), modify.set('Reset', 0));
  }

  //Funnction used to read data from the users collection
  static Future<List<Map<String, dynamic>>> getData(String email) async {
    final arrData =
        await userCollection.find(where.eq("Email", email)).toList();
    return arrData;
  }

  //Function used to read data from the blocked users collection
  static Future<List<Map<String, dynamic>>> getDataInvalid(String email) async {
    final arrData = await invalidUser.find(where.eq("Email", email)).toList();
    return arrData;
  }

  //Function used to insert data into blocked user collection
  static Future<void> insertInvalid(validUser data) async {
    await invalidUser.insertOne(data.toJson());
  }

  //Function used to insert data into users collection
  static Future<void> insertData(MongoDbModel data) async {
    await userCollection.insertOne(data.toJson());
  }

  static Future<List<Map<String, dynamic>>> notification() async{
    final data = await notificationCollection.find().toList();
    return data;
  }
  
  static Future<void>insertnotification( NotificationModel data) async{
    await notificationCollection.insertOne(data.toJson());
  }

}
