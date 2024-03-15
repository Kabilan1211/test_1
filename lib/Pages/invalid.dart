// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

//This is the blocked user login page

class wrongCredential extends StatefulWidget {
  const wrongCredential({super.key});

  @override
  State<wrongCredential> createState() => _wrongCredentialState();
}

class _wrongCredentialState extends State<wrongCredential> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("TEST"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your account has been blocked since you have entered wrong credentials for 3 times",
              style: TextStyle(color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Contact admin to reset your password",
              style: TextStyle(color: Colors.deepPurple),
            ),
            //For debugging purpose
            // ElevatedButton(onPressed: () => invalidUser(emailId), child: const Text("Read"))
          ],
        ),
      ),
    );
  }
}
