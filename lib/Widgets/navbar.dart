// ignore_for_file: file_names, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:test_1/Pages/login.dart';
import 'package:test_1/Widgets/read.dart';

// This is Navigation drawer page

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Returning a drawer to access various page route from the home page itself
    return Drawer(
      backgroundColor: Colors.deepPurple.shade200,
      child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  //Can change the image by updating the path here and in pubspec yaml file
                  'images/profile.jpg',
                ),
                radius: 50,
              ),
            ),
            const Divider(height: 50, color: Colors.deepPurple),
            const Text(
              'NAME',
              style: TextStyle(
                color: Colors.deepPurple,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$firstName $lastName',
              style: const TextStyle(
                color: Colors.deepPurple,
                letterSpacing: 2.0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$emailId',
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Tile(
                icons: Icon(Icons.notifications),
                text: "Notification",
                fun: Login()),
          ]),
    );
  }
}

//Creating a class "Tile" to display in the Navigation drawer
class Tile extends StatelessWidget {
  const Tile(
      {super.key, required this.icons, required this.text, required this.fun});
  final Widget? icons;
  final String text;
  final Widget fun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.deepPurple,
        ),
        ListTile(
          title: Text(text),
          leading: icons ??
              const Icon(
                Icons.abc,
                color: Colors.deepPurple,
              ),
          iconColor: Colors.deepPurple,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => fun),
          ),
        ),
      ],
    );
  }
}
