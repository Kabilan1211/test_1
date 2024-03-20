import 'package:flutter/material.dart';
import 'package:test_1/Widgets/read.dart';

class Newnotification{

bool newNotification(String previousTitle, String lastTitle, String previousBody, String lastBody){
  if(previousTitle != lastTitle || previousBody != lastBody){
    previousNotificationNumber = currentNotificationNumber;
    previousTitle = lastTitle;
    previousBody = lastBody;
    return true;
  }
  else{
    return false;
  }
}

void check(){
  if(newNotification(previousTitle, lastTitle, previousBody, lastBody)){
    print("New Notification Detected");
  }
}
 

}