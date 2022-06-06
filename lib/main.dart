import 'package:exhibition/Screens/Auth/Login.dart';
import 'package:exhibition/Screens/Auth/Signup.dart';
import 'package:exhibition/Screens/WelcomePage/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/Auth/ForgotPassword.dart';
import 'Screens/Home/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.white),
      ),
      initialRoute: "/welcome",
      getPages: [
        GetPage(name: "/", page: () => const Login()),
        GetPage(name: '/signup', page: () => const Signup()),
        GetPage(name: '/forgotpassword', page: () => const ForgotPassword()),
        GetPage(name: '/welcome', page: () => const Welcome()),
        GetPage(name: '/home', page: () => const Home()),
      ],
    );
  }
}
