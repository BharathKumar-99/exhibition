import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:exhibition/Services/Auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Dimentions.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  File? _panFront, _panBack, _aadharFront, _aadharBack;

  final picker = ImagePicker();

  Future _panFrontPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _panFront = File(pickedFile.path);
      setState(() {});
      print('_image: $_panFront');
    } else {
      print('No image selected');
    }
  }

  Future _panBackPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _panBack = File(pickedFile.path);
      setState(() {});
      print('_image: $_panBack');
    } else {
      print('No image selected');
    }
  }

  Future _aadharFrontPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _aadharFront = File(pickedFile.path);
      setState(() {});
      print('_image: $_aadharFront');
    } else {
      print('No image selected');
    }
  }

  Future _aadharBackPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _aadharBack = File(pickedFile.path);
      setState(() {});
      print('_image: $_aadharBack');
    } else {
      print('No image selected');
    }
  }

  _signup(
      String email,
      String password,
      String name,
      String phone,
      File? panFront,
      File? panBack,
      File? aadharFront,
      File? aadharBack) async {
    String base64Image = base64Encode(panFront!.readAsBytesSync());

    Auth.signup(panFront);
    //TODO: Signup
  }

  _passwordtoggle() {
    setState(() {
      _obscureText ? _obscureText = false : _obscureText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

                  //TextField Confirm Password

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

                  /*
Uplaod Image
                   

                  */
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Upload Document",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.libreFranklin(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: Dimentions.height10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pan Card",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.libreFranklin(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: Dimentions.height150,
                        width: Dimentions.width150,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Dimentions.height105,
                                width: Dimentions.width45percent,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _panFront == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 45,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _panFront!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Dimentions.width150,
                                child: ElevatedButton(
                                    onPressed: () => _panFrontPicker(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: Text(
                                      "Upload Front",
                                      style: GoogleFonts.libreFranklin(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimentions.height150,
                        width: Dimentions.width150,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Dimentions.height105,
                                width: Dimentions.width45percent,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _panBack == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 45,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _panBack!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Dimentions.width150,
                                child: ElevatedButton(
                                    onPressed: () => _panBackPicker(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: Text(
                                      "Upload Back",
                                      style: GoogleFonts.libreFranklin(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimentions.height10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Adhar Card",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.libreFranklin(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: Dimentions.height150,
                        width: Dimentions.width150,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Dimentions.height105,
                                width: Dimentions.width45percent,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _aadharFront == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 45,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _aadharFront!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Dimentions.width150,
                                child: ElevatedButton(
                                    onPressed: () => _aadharFrontPicker(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: Text(
                                      "Upload Front",
                                      style: GoogleFonts.libreFranklin(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimentions.height150,
                        width: Dimentions.width150,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Dimentions.height105,
                                width: Dimentions.width45percent,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _aadharBack == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 45,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _aadharBack!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: Dimentions.width150,
                                child: ElevatedButton(
                                    onPressed: () => _aadharBackPicker(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    child: Text(
                                      "Upload Back",
                                      style: GoogleFonts.libreFranklin(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimentions.height20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.lightBlueAccent,
                          elevation: 5,
                        ),
                        onPressed: () => _signup(
                            _emailController.text,
                            _passwordController.text,
                            _confirmPasswordController.text,
                            _phoneController.text,
                            _panFront,
                            _panBack,
                            _aadharFront,
                            _aadharBack),
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
