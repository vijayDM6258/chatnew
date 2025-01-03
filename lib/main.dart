import 'dart:async';

import 'package:chatnew/firebase_options.dart';
import 'package:chatnew/view/home_page.dart';
import 'package:chatnew/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // home: LoginPage(),
      initialRoute: FirebaseAuth.instance.currentUser?.uid != null ? "home_page" : "/",
      getPages: [
        GetPage(
          name: "/",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/home_page",
          page: () => HomePage(),
        )
      ],
    );
  }
}
