// ignore_for_file: avoid_print

import 'package:test_1/Widgets/read.dart';

//This page contains the authentication logic 

class Auth {

  //Function to check the user is authentic
  static bool authCheck(String email, String password) {
    if (dataBaseEmail == email && dataBasePassword == password) {
      print(dataBaseEmail);
      return true;
    } else {
      print(dataBasePassword);
      return false;
    }
  }
}
