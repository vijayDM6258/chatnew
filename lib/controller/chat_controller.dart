import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  }
}
