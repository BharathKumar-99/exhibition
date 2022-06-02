import 'package:exhibition/Screens/Auth/Login.dart';
import 'package:exhibition/Screens/Auth/Signup.dart';
import 'package:exhibition/Utils/Dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/Auth/ForgotPassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(Dimentions.height);
    print(Dimentions.width);

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const Login()),
        GetPage(name: '/signup', page: () => const Signup()),
        GetPage(name: '/forgotpassword', page: () => const ForgotPassword()),
      ],
    );
  }
}
