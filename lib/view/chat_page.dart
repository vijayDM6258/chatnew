import 'package:chatnew/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatController controller = Get.put(ChatController());

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.arg["email"]}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                bool isSender = index % 2 == 0;
                return Align(
                  alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black54),
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 1.2),
                    margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                    padding: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                    child: Text("Hi $isSender" * 10),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(hintText: "Message", border: OutlineInputBorder()),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    if (controller.msgController.text.trim().isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection("message")
                          .add({"msg": controller.msgController.text, "time": DateTime.now(), "chat_room_id": controller.arg["chat_room_id"]});
                      controller.msgController.clear();
                    }
                  },
                  icon: Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }
}
