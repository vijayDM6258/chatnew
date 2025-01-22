import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoad.value) {
                return CupertinoActivityIndicator(
                  color: Colors.black,
                  radius: 20,
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            SizedBox(height: 10),
            TextFormField(
              controller: controller.email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        controller.login();
                      },
                      child: Text("Login")),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        controller.register();
                      },
                      child: Text("Register")),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
                  try {
                    var act = await _googleSignIn.signIn();
                    print("act ${act?.email}");
                    print("act ${act?.id}");
                  } catch (e) {
                    print("google Error $e");
                  }
                },
                child: Text("Google login"))
          ],
        ),
      ),
    );
  }
}
