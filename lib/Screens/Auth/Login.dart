// ignore_for_file: file_names

import 'dart:ui';

import 'package:exhibition/Utils/Dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _login(String email, String password) {
    //TODO: Login
  }

  _passwordtoggle() {
    setState(() {
      _obscureText ? _obscureText = false : _obscureText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      height: Dimentions.height100,
                      width: Dimentions.width100,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                    ),
                  )
                ],
              ),
              SizedBox(height: Dimentions.height20),
              const Text(
                'Login',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimentions.height30),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.libreFranklin(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(22, 33, 149, 243),
                        hintText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email_rounded,
                          size: 35,
                          color: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimentions.height10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.libreFranklin(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    TextField(
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        suffixIcon: _obscureText
                            ? IconButton(
                                onPressed: (() => _passwordtoggle()),
                                icon: const Icon(
                                  Icons.visibility_off_rounded,
                                  size: 35,
                                  color: Colors.blueAccent,
                                ),
                              )
                            : IconButton(
                                onPressed: (() => _passwordtoggle()),
                                icon: const Icon(Icons.visibility_rounded,
                                    size: 35, color: Colors.blueAccent),
                              ),
                        fillColor: const Color.fromARGB(22, 33, 149, 243),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimentions.height10),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Get.toNamed('/forgotpassword'),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.libreFranklin(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.lightBlueAccent,
                            elevation: 5,
                          ),
                          onPressed: () => _login(
                              _emailController.text, _passwordController.text),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: GoogleFonts.libreFranklin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimentions.height20),
              GestureDetector(
                onTap: () => Get.toNamed('/signup'),
                child: Text(
                  "Don't have an account? Register Now",
                  style: GoogleFonts.libreFranklin(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
