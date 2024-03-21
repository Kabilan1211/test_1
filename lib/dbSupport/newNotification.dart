// ignore_for_file: avoid_print, file_names

import 'package:test_1/Widgets/read.dart';

class Newnotification {
  bool newNotification(int num1, int num2) {
    if (num1 != num2) {
      return true;
    } else {
      return false;
    }
  }
}

void check() {
  final newNotificationInstance = Newnotification();
  if (newNotificationInstance.newNotification(previousNotificationNumber, currentNotificationNumber)) {
    print("New Notification Detected");
    previousNotificationNumber = currentNotificationNumber;
  }
  readNotification();
  Future.delayed(const Duration(seconds: 2), check);
}
