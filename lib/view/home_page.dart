import 'package:chatnew/controller/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    initNotification();
    FirebaseMessaging.onMessage.listen(
      (event) {
        print("Notification title  => ${event.notification?.title}");
        print("Notification desc   => ${event.notification?.body}");
        showAppNotification(event.notification?.title ?? "", event.notification?.body ?? "");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${FirebaseAuth.instance.currentUser?.email ?? ""}"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Name"),
            subtitle: Text("Last Msg"),
            trailing: Text("Time"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed("users_page");
        },
        child: Icon(Icons.person),
      ),
    );
  }

  void initNotification() {
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')),
    );
  }

  void showAppNotification(String title, String desc) async {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "Chat",
          "ChatApp",
        ),
      ),
    );
  }
}
