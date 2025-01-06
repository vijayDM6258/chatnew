import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").get().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List users = snapshot.data?.docs ?? [];
              print("User $users");
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
                  return ListTile(
                    title: Text("${user["email"]}"),
                    onTap: () {
                      Get.toNamed("chat_page");
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
