// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, library_prefixes, avoid_print

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:test_1/Widgets/textField.dart';
import 'package:test_1/Widgets/auth.dart';
import 'package:test_1/Pages/invalid.dart';
import 'package:test_1/Pages/main.dart';
import 'package:test_1/Widgets/read.dart';
import 'package:test_1/Pages/updatePass.dart';
import 'package:test_1/dbSupport/mongo.dart';
import 'package:test_1/dbSupport/mongoDBModel.dart';
import 'package:test_1/dbSupport/validUser.dart';

//This is the Login page

int validate_login = 0;
String emailId = "";
String password = "";
String First_Name = "";
String Last_Name = "";
int count = 0;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Assigning the values entered in the form field to a final variable
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Function  to validate the email address format
    String? _validateEmail(String? value) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return 'Enter a valid email address';
      }
      return null;
    }

    //Function to validate the password is strong
    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Enter a password';
      } else if (!isPasswordStrong(value)) {
        return 'Password must be at least 8 characters long and contain uppercase, lowercase, digits, and special characters';
      }
      return null;
    }

    //Function to Insert the Invalid user into database collection "Invalid_users"
    Future<void> _insertInvalid(String firstName, String lastName, String email,
        String password, int validuser) async {
      var id1 = M.ObjectId();
      final data = validUser(
          id: id1,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          valid_User: validuser);
      MongoDatabase.insertInvalid(data);
    }

    //Function to Insert the user into the database collection "users"
    Future<void> _insertuser(String firstName, String lastName, String email,
        String password, int Reset) async {
      var id1 = M.ObjectId();
      final data = MongoDbModel(
          id: id1,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          reset: Reset);
      MongoDatabase.insertData(data);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text(
          "LOGIN",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField1(
                controller: _emailController,
                hintText: "Enter your Email",
                secureText: false,
                validator: _validateEmail,
              ),
              CustomTextField1(
                controller: _passwordController,
                hintText: "Enter Your password",
                secureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {

                  //Validate the form details that the criterias for Email and Password are met
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      emailId = _emailController.text;
                      password = _passwordController.text;
                      First_Name = firstName;
                      Last_Name = lastName;
                    });

                    //Calling the fetchData and invalidUser Function to read the user details
                    fetchData(emailId);
                    invalidUser(emailId);

                    //Checking user is not in the blocked list
                    if (valid == 1) {
                      //Checking the email and password matches to the database
                      if (Auth.authCheck(
                          _emailController.text, _passwordController.text)) {
                        setState(() {
                          count = 0;
                        });

                        //Route the user to Reset Password page
                        if (reset == 1) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const ResetPass())),
                              (route) => false);
                        } 
                        //Route the user to Home page
                        else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const MyHomePage())),
                              (route) => false);
                        }
                      } else {
                        print("Authentication Error");
                        setState(() {
                          count++;
                        });
                        //if user failed to enter the details correctly, his details will be updated to the blocked user list
                        if (count == 3) {
                          _insertInvalid(First_Name, Last_Name, emailId,
                              dataBasePassword, 1);
                          //Route to the blocked user page
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const wrongCredential())),
                              (route) => false);
                        }
                      }
                    } else {
                      print("Enter valid email and password");
                      _clearall();
                    }
                  } else {
                    //Route the user to blocked users page
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const wrongCredential())),
                        (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade200,
                ),
                child: const Text("Login"),
              ),
              const SizedBox(height: 20,),
              
              //Used to add users into database
              // ElevatedButton(onPressed: (){
              //   _insertuser("Surya", "K","SuryaKrish@gmail.com", "09102000@Vv", 1);
              //   print("Done");
              // }, child: const Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
  
  //Function to clear the text in the form field
  void _clearall() {
    _emailController.text = "";
    _passwordController.text = "";
  }
}
