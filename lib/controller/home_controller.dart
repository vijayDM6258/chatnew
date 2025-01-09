import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late AppLifecycleListener appLifecycleListener;

  @override
  void onInit() {
    super.onInit();
    appLifecycleListener = AppLifecycleListener(
      onStateChange: (value) {
        print("AppLifecycleListener $value");
        if (value == AppLifecycleState.resumed) {
          // FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid ?? "").get().then((value) {
          //   var data = value.data();
          //   print("user Data $data");
          // });

          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).update({
            "isOnline": true,
          });
          // user is onLine
        } else if (value == AppLifecycleState.paused) {
          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).update({
            "isOnline": false,
          });
          // user is offLine
        }
      },
    );
    // appLifecycleListener.dispose();
  }
}
