// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test_1/dbSupport/mongo.dart';
import 'package:test_1/dbSupport/notificationModel.dart';

int? length = 0;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Map<String, Object?>>>(
            future: MongoDatabase.notification(), // Adjust this method according to your implementation
            builder: (context, AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                length = snapshot.data?.length;
                print(length);
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return buildNotificationCard(NotificationModel.fromJson(snapshot.data![index]));
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                return const Center(
                  child: Text("No data available"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildNotificationCard(NotificationModel data) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(data.title),
        subtitle: Text(data.body),
      ),
    );
  }
}
