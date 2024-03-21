// ignore_for_file: avoid_print, file_names

import 'package:test_1/Widgets/read.dart';

class Newnotification {

  // Function used to verify, it is the last notification
  bool newNotification(int num1, int num2) {
    if (num1 != num2) {
      return true;
    } else {
      return false;
    }
  }
}

// Function tells the last notification
void check() {
  final newNotificationInstance = Newnotification();
  if (newNotificationInstance.newNotification(previousNotificationNumber, currentNotificationNumber)) {
    // For debugging Purpose
    // print("New Notification Detected");
    previousNotificationNumber = currentNotificationNumber;
  }
  readNotification();
  Future.delayed(const Duration(seconds: 2), check);
}
