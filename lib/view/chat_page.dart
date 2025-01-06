import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other User Email"),
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
                  decoration: InputDecoration(hintText: "Message", border: OutlineInputBorder()),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }
}
