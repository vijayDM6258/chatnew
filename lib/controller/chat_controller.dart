import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late Map<String, dynamic> arg;
  TextEditingController msgController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    arg = Get.arguments;
  }
}
