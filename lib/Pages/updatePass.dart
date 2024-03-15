// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:test_1/Widgets/textField.dart';
import 'package:test_1/dbSupport/mongo.dart';
import 'package:test_1/Pages/login.dart';
import 'package:test_1/Pages/main.dart';
import 'package:test_1/Widgets/read.dart';

//This is the reset password page

int validate = 0;
String? old_password;
String? new_password;
String? new_password2;

//Function to check the password is strong or not
bool isPasswordStrong(String password) {
  const minLength = 8;
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  return password.length >= minLength &&
      hasUppercase &&
      hasLowercase &&
      hasDigits &&
      hasSpecialChars;
}

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

  //Assigning the values entered in the form field to a final variable
  final _passwordController = TextEditingController();
  final _resetPassword = TextEditingController();
  final _checker = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Function to update the data to the database
  Future<void> _updateData(String password, String old) async {
    await MongoDatabase.update(password, old);
  }

  @override
  Widget build(BuildContext context) {

    //Function to validate the password
    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Enter a password';
      } else if (!isPasswordStrong(value)) {
        return 'Password must be at least 8 characters long and contain uppercase, lowercase, digits, and special characters';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(
                controller: _passwordController,
                hintText: "Enter your old password",
                secureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter your old password';
                  }
                  // Perform any additional validation if needed
                  return null;
                },
              ),
              CustomTextField1(
                  controller: _resetPassword,
                  hintText: "Enter your new password",
                  secureText: true,
                  validator: _validatePassword),
              CustomTextField1(
                controller: _checker,
                hintText: "Enter your new password again",
                secureText: true,
                validator: (val) {
                  // print(val);
                  if (val == null || val.isEmpty) {
                    return 'Re-enter your new password';
                  } else if (val != _resetPassword.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  //Validating the form
                  if (_formKey.currentState!.validate()) {
                    //Checking that the new password entered correctly for twice
                    if (_resetPassword.text == _checker.text) {
                      //Checking that the new password is not old password
                      if (_passwordController.text != _checker.text) {
                        //Checking the password in the database  is matching with the entered password
                        if (dataBasePassword == _passwordController.text) {
                          setState(() {
                            validate = 1;
                          });
                        }
                      } else {
                        validate = 0;
                      }
                      if (validate == 1) {
                        //Route to my home page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const MyHomePage())));
                        //calling the update data function to update the password to the database
                        _updateData(_checker.text, emailId);
                      } else {}
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade200,
                ),
                child: const Text("Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
