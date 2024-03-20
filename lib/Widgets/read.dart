// ignore_for_file: avoid_print, camel_case_types

import 'package:test_1/dbSupport/mongo.dart';

// initializing the global variables to access from other pages
//This page contains function to read data from the database

int reset = 0;
int valid = 0;
String dataBaseEmail = "";
String dataBasePassword = "";
String firstName = "";
String lastName = "";
String lastTitle ="";
String lastBody ="";
String previousTitle = "";
String previousBody = "";
int currentNotificationNumber = 0;
int previousNotificationNumber = 0;

//fetch data from the user collection from the database

Future<void> fetchData(String email) async {
  try {
    final List<Map<String, dynamic>> dataList =
        await MongoDatabase.getData(email);
    if (dataList.isNotEmpty) {
      final Map<String, dynamic> data = dataList.first;
      reset = data['Reset'] ?? 0;
      dataBaseEmail = data['Email'] ?? "";
      dataBasePassword = data['Password'] ?? "";
      firstName = data['first name'] ?? "";
      lastName = data['last name'] ?? "";

      // For debugging purpose
      // print(data);
      // print(reset);
      // print(dataBasePassword);
      // print(dataBaseEmail);
      // print(firstName);
      // print(lastName);
    }
  } catch (e) {
    // print("Error fetching data: $e");
  }
}

//fetch data from the invalid user collection

Future<void> invalidUser(String email) async {
  try {
    final List<Map<String, dynamic>> dataList =
        await MongoDatabase.getDataInvalid(email);
    if (dataList.isNotEmpty) {
      final Map<String, dynamic> data = dataList.first;
      valid = data['Valid User'] ?? 0;

      //for debugging purpose
      print(valid);
    }
    else{
      valid = 1;
      print(valid);

    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}

Future<void> readNotification() async{
  try{
    final dataList = await MongoDatabase.notification();
    if(dataList.isNotEmpty){
      final Map<String, dynamic> data = dataList.last;
      lastTitle = data['Title'] ?? "";
      lastBody = data['Body'] ?? "";
      currentNotificationNumber = data[''] ??0;
      print(lastTitle);
      print(lastBody);
    }
  }
  catch(e){
    print(e.toString());
  }
  // Future.delayed(const Duration(seconds: 2),readNotification);

}