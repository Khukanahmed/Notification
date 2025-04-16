import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/login/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                //Get.to();
                if (kDebugMode) {
                  print('object');
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,

                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Google', style: TextStyle(fontSize: 25)),
                    Image.asset('asset/google.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Google', style: TextStyle(fontSize: 25)),
                  Image.asset('asset/google.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
