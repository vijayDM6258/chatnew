import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  late Map<String, dynamic> arg;
  TextEditingController msgController = TextEditingController();

  ScrollController scrollController = ScrollController();

  void jumpToEnd() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        var maxScrollExtent = scrollController.position.maxScrollExtent;
        scrollController.jumpTo(maxScrollExtent);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    arg = Get.arguments;
    FirebaseFirestore.instance.collection("chat_room").doc(arg["chat_room_id"]).update({
      "unread": 0,
    });
  }

  Future<void> sendNotification(String text) async {
    Map<String, dynamic> payload = {
      "token": "fkGZeZcIQTOaU16ljAgqG1:APA91bGGNUg-dMr9GxENkqxafzEOTsqb-7ARHKIX_xulr3lD4JxluOJvhQXngSciA6kjUVsCD2D4PWomtg3_LnQeKNT0kgKS4qkvkYQI5v9TmfQN8Ko6ozw",
      "title": "New chat Message",
      "msg": text
    };
    print("sendNotification $payload");

    http.Response res = await http.post(
      Uri.parse("http://localhost:3000/notificaiton"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    print("sendNotification $res");
  }
}
