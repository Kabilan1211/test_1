import 'package:flutter/material.dart';
import 'package:test_1/dbSupport/mongo.dart';
import 'package:test_1/Pages/splash.dart';
import 'dart:async';
import 'package:test_1/Pages/login.dart';
import 'package:test_1/Widgets/navbar.dart';

//This is the home page

void main() async {
  //Run the app after ensuring the widget is loaded

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      //At first Splash page will be loaded
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Function to route the user to signout page
  Future<void> signOut() async {
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.person))
        ],
        backgroundColor: Colors.deepPurple[200],
        title: const Text("TEST"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to our App"),
            Text("From now onwards you will notifications from us !"),

            // For debugging Purpose
            // ElevatedButton(onPressed: (){
            //   fetchData(emailId);
            //   },
            //    child: const Text("Read"))
          ],
        ),
      ),
    );
  }
}
