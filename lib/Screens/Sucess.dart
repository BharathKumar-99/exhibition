import 'package:exhibition/Screens/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/success.json'),
            const Text("Success", style: TextStyle(fontSize: 30)),
            const Text("Your account has been created successfully",
                style: TextStyle(fontSize: 15)),
            ElevatedButton(
                onPressed: () => Get.off(const Login()),
                child: const Text("Back to Login"))
          ],
        ),
      ),
    );
  }
}
