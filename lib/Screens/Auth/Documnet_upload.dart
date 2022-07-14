import 'dart:io';

import 'package:exhibition/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/Dimentions.dart';
import '../Sucess.dart';

class DocumentUpload extends StatefulWidget {
  const DocumentUpload({Key? key}) : super(key: key);

  @override
  State<DocumentUpload> createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  File? _panFront, _panBack, _aadharFront, _aadharBack;
  bool _isLoading = false;

  final picker = ImagePicker();

  _Documentupload(File? panFront, File? panBack, File? aadharBack,
      File? aadharFront) async {
    setState(() {
      _isLoading = true;
    });
    var response =
        await Auth.uploadDocuments(panFront, panBack, aadharFront, aadharBack);
    if (response == "Document Uploaded Successfully!") {
      setState(() {
        _isLoading = false;
      });
      Get.off(() => const Success());
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.off(() => const Success());
    }
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

  Future _panFrontPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _panFront = File(pickedFile.path);
      setState(() {});
    }
  }

  Future _panBackPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _panBack = File(pickedFile.path);
      setState(() {});
    }
  }

  Future _aadharFrontPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _aadharFront = File(pickedFile.path);
      setState(() {});
    }
  }

  Future _aadharBackPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _aadharBack = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Upload Profile Pic",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreFranklin(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: Dimentions.height30),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profile Pic",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreFranklin(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height160,
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
                                        MaterialStateProperty.all(Colors.white),
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
                                    "Upload Profilepic",
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Upload Document",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.libreFranklin(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: Dimentions.height50),
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
                          height: Dimentions.height160,
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
                                        elevation:
                                            MaterialStateProperty.all(0.0),
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
                          height: Dimentions.height160,
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
                                        elevation:
                                            MaterialStateProperty.all(0.0),
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
                          height: Dimentions.height160,
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
                                        elevation:
                                            MaterialStateProperty.all(0.0),
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.lightBlueAccent,
                          elevation: 5,
                        ),
                        onPressed: () => (_aadharBack != null ||
                                _aadharFront != null ||
                                _panBack != null ||
                                _panFront != null)
                            ? _Documentupload(
                                _panFront,
                                _panBack,
                                _aadharFront,
                                _aadharBack,
                              )
                            : showDialog(
                                "Error",
                                "Password and Confirm Password does not match",
                              ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Upload",
                            style: GoogleFonts.libreFranklin(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
