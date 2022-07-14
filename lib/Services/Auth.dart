// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:exhibition/Model/Signupmodel.dart';
import 'package:exhibition/Model/UPlaodDocResmodel.dart';
import 'package:exhibition/Model/response.dart';
import 'package:exhibition/Screens/Auth/AutoLogin.dart';
import 'package:exhibition/Utils/Connections.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as mio;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static var client = http.Client();
  static var dio = Dio();

//Login
  static Future<String>? login(String email, String password) async {
    var data = {'email': email, 'password': password};
    ResponseModel result = ResponseModel();
    var usersDataFromJson;
    String response = " ";
    try {
      await client.post(Uri.parse(con.loginapi), body: data).then((value) => {
            if (value.statusCode == 200)
              {
                if (value.body == "Document upload Pending")
                  {response = "doc pending"}
                else if (value.body == "Invalid Email or Password")
                  {response = "failure"}
                else
                  {
                    result = ResponseModel.fromJson(json.decode(value.body)),
                    if (result.email == email)
                      {
                        response = "success",
                        Autologin.setLogin(result),
                      }
                  }
              }
            else
              {response = "failure"}
          });
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return response;
  }

//Signup
  static Future<String> signup(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    var data = {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      "pan_front": "not uploaded",
      "pan_back": "not uploaded",
      "aadhar_front": "not uploaded",
      "aadhar_back": "not uploaded",
    };

    String result = "";
    SignupResponse res = SignupResponse();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await http
          .post(Uri.parse(con.registerapi),
              headers: {"Content-Type": "application/json"},
              body: json.encode(data))
          .then((value) => {
                if (value.statusCode == 200)
                  {
                    res = SignupResponse.fromJson(json.decode(value.body)),
                    if (res.message == "Registration Successful!")
                      {
                        result = "Registration Successful!",
                        //update shared prefrence
                        prefs.setString('id', res.id.toString()),

                        prefs.setString('emailsignup', email),
                      }
                    else if (res.message == "Document upload Pending")
                      {
                        result = "Document upload Pending",
                        prefs.setString('id', res.id.toString()),
                        prefs.setString('emailsignup', email),
                      }
                    else
                      {result = res.message.toString()}
                  }
              });
    } catch (e) {
      print(e);
    }
    return result;
  }

  static Future<String> uploadDocuments(
    File? panFront,
    File? panBack,
    File? aadharFront,
    File? aadharBack,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = "";

    var id = prefs.getString('emailsignup');
    var uri = Uri.parse(con.uploadDocument);
    var request = http.MultipartRequest("POST", uri);
    var panfront =
        await http.MultipartFile.fromPath('pan_front', panFront!.path);
    var panback = await http.MultipartFile.fromPath('pan_back', panBack!.path);
    var aadharfront =
        await http.MultipartFile.fromPath('aadhar_front', aadharFront!.path);
    var aadharback =
        await http.MultipartFile.fromPath('aadhar_back', aadharBack!.path);
    request.files.add(panfront);
    request.files.add(panback);
    request.files.add(aadharfront);
    request.files.add(aadharback);
    var formData = mio.FormData.fromMap({
      'pan_front': await mio.MultipartFile.fromFile(panFront.path,
          filename: panFront.path),
      'profile_pic': await mio.MultipartFile.fromFile(panBack.path,
          filename: panBack.path),
      'aadhar_front': await mio.MultipartFile.fromFile(aadharFront.path,
          filename: aadharFront.path),
      'aadhar_back': await mio.MultipartFile.fromFile(aadharBack.path,
          filename: aadharBack.path),
    });

    Upload_Document_result res = Upload_Document_result();
    try {
      var response =
          await dio.post(con.uploadDocument, data: formData).then((value) => {
                if (value.statusCode == 200)
                  {
                    res = Upload_Document_result.fromJson(
                        json.decode(value.data)),
                    if (res.message == "Document Uploaded Successfully!")
                      {
                        result = "Document Uploaded Successfully!",
                      }
                    else
                      {
                        result = res.message.toString(),
                      },
                  }
              });
    } catch (e) {
      result = "Error";
    }
    var update = updatedoc(
      res.panFront.toString(),
      res.profilePic.toString(),
      res.aadharFront.toString(),
      res.aadharBack.toString(),
    );
    if (update == "Updated") {
      result = "Document Uploaded Successfully!";
    } else {
      result = "Error";
    }
    return result;
  }

  static Future<String> updatedoc(
    String panFront,
    String profilepic,
    String aadharFront,
    String aadharBack,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = "";

    var id = prefs.getString('emailsignup');
    var uri = Uri.parse(con.uploadDocumentDetails);
    var data = {
      "email": id,
      "pan_front": panFront,
      "profile_pic": profilepic,
      "aadhar_front": aadharFront,
      "aadhar_back": aadharBack,
    };
    http.post(uri, body: data).then((value) => {
          if (value.statusCode == 200)
            {
              if (value.body == "Updated")
                {result = "Updated"}
              else
                {result = "Error"}
            }
          else
            {
              result = "Error",
            },
        });

    return result;
  }
}
