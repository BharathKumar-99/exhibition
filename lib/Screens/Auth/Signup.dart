// ignore_for_file: file_names

import 'dart:ui';
import 'package:exhibition/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/Dimentions.dart';
import 'Documnet_upload.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  clear() {
    _emailController.text = "";
    _passwordController.text = "";
    _nameController.text = "";
    _phoneController.text = "";

    _confirmPasswordController.text = "";
    setState(() {
      _loading = false;
    });
  }

  showDialog(
    String title,
    var message,
  ) {
    Get.defaultDialog(
        title: title,
        middleText: message.toString(),
        backgroundColor: Theme.of(context).primaryColor,
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        radius: 30);
  }

  _signup(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    //non cancel circular progress indicator
    setState(() {
      _loading = true;
    });
    await Auth.signup(email, password, name, phone).then((value) => {
          if (value == "Registration Successful!")
            {
              Get.to(() => const DocumentUpload()),
              clear(),
            }
          else if (value == "Document upload Pending")
            {
              showDialog(
                "Error",
                "$value Upload It First",
              ),
              clear(),
            }
          else
            {
              showDialog(
                "Error",
                value,
              ),
            }
        });
  }

  _passwordtoggle() {
    setState(() {
      _obscureText ? _obscureText = false : _obscureText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading.json'),
                  Text(
                    "Signing You Up...",
                    style: GoogleFonts.lato(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: Dimentions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
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
                    'Signup',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Dimentions.height30),

                  //TextField Email

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
                        //TextField Password
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
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Confirm Password",
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
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Comfirm Password',
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
                        SizedBox(
                          height: Dimentions.height10,
                        ),
                        //TextField Name
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.libreFranklin(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(22, 33, 149, 243),
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimentions.height10,
                        ),

                        //TextField Phone
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Phone",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.libreFranklin(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          controller: _phoneController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(22, 33, 149, 243),
                            hintText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimentions.height10),

                        SizedBox(height: Dimentions.height20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.lightBlueAccent,
                                elevation: 5,
                              ),
                              onPressed: () => (_passwordController.text ==
                                      _confirmPasswordController.text)
                                  ? _signup(
                                      _emailController.text,
                                      _passwordController.text,
                                      _nameController.text,
                                      _phoneController.text,
                                    )
                                  : showDialog(
                                      "Error",
                                      "Password and Confirm Password does not match",
                                    ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Register",
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
                    onTap: () => Get.toNamed('/'),
                    child: Text(
                      "Already have an account? Login Now",
                      style: GoogleFonts.libreFranklin(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
