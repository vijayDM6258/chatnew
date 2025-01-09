import 'package:chatnew/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(controller.arg["receiver_id"]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var otherUser = snapshot.data?.data() as Map<String, dynamic>;
                    print("snapshot.data.runtimeType ${otherUser}");
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(otherUser["isOnline"] ? "Online" : "Offline"),
                        Icon(
                          Icons.circle,
                          size: 12,
                          color: otherUser["isOnline"] ? Colors.green : Colors.red,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("message").orderBy('time').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var msgList = snapshot.data?.docs ?? [];
                    controller.jumpToEnd();
                    return ListView.builder(
                      itemCount: msgList.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        var msg = msgList[index];
                        Map<String, dynamic> data = msg.data() as Map<String, dynamic>;

                        bool isSender = data["sender"] == FirebaseAuth.instance.currentUser?.uid;
                        return Align(
                          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black54),
                            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width / 1.2),
                            margin: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                            padding: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                            child: Text(
                              "${data["msg"]}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
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
                      await FirebaseFirestore.instance.collection("message").add({
                        "msg": controller.msgController.text,
                        "time": DateTime.now(),
                        "chat_room_id": controller.arg["chat_room_id"],
                        "sender": FirebaseAuth.instance.currentUser?.uid,
                        "receiver": controller.arg["receiver_id"]
                      });
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
