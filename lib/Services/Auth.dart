// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:exhibition/Model/response.dart';
import 'package:exhibition/Screens/Auth/Login.dart';
import 'package:exhibition/Utils/Connections.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Auth {
  static var client = http.Client();

//Login
  static Future<ResponseModel>? login(String email, String password) async {
    var data = {'email': email, 'password': password};
    ResponseModel result = ResponseModel();

    try {
      await client
          .post(Uri.parse(con.loginapi), body: json.encode(data))
          .then((value) => {
                if (value.statusCode == 200)
                  {
                    result = ResponseModel.fromJson(json.decode(value.body)),
                  }
                else
                  {result = ResponseModel()}
              });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return result;
  }

//Signup
  static Future<String> signup(
      String email,
      String password,
      String name,
      String phone,
      File? panFront,
      File? panBack,
      File? aadharFront,
      File? aadharBack) async {
//upload image to server
    String result = "";
    var uri = Uri.parse(con.registerapi);
    var request = http.MultipartRequest("POST", uri);
    var panfront = await http.MultipartFile.fromPath('image', panFront!.path);
    var panback = await http.MultipartFile.fromPath('image1', panBack!.path);
    var aadharfront =
        await http.MultipartFile.fromPath('image2', aadharFront!.path);
    var aadharback =
        await http.MultipartFile.fromPath('image3', aadharBack!.path);
    request.files.add(panfront);
    request.files.add(panback);
    request.files.add(aadharfront);
    request.files.add(aadharback);
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['mobile'] = phone;

    await request.send().then((response) {
      http.Response.fromStream(response).then((onValue) {
        try {
          if (json.decode(onValue.body) == "User Registered Successfully") {
            Get.off(const Login());
          } else {
            Get.defaultDialog(
                title: "Error",
                middleText: onValue.body,
                backgroundColor: Colors.blueAccent,
                titleStyle: const TextStyle(color: Colors.white),
                middleTextStyle: const TextStyle(color: Colors.white),
                radius: 30);
          }
        } catch (e) {
          result = onValue.body;
          return result;
        }
      });
    });
    return "result";
  }
}
