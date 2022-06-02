import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:exhibition/Utils/Connections.dart';
import 'package:http/http.dart' as http;

class Auth {
  static var client = http.Client();

//Login
  static Future<Object> login(String email, String password) async {
    var data = {'email': email, 'password': password};

    try {
      var response =
          await client.post(Uri.parse(con.loginapi), body: json.encode(data));

      return json.decode(response.body);
    } catch (e) {
      print("${e}error");
      return e;
    }
  }

//Signup
  static void signup(
    // String email,
    // String password,
    // String name,
    // String phone,
    File? panFront,
    // File? panBack,
    // File? aadharFront,
    // File? aadharBack
  ) async {
    String fileName = basename(panFront!.path);
    print("File base name: $fileName");

    try {
      String fileName = panFront.path.split('/').last;
      FormData formData = FormData.fromMap({
        "panfront":
            await MultipartFile.fromFile(panFront.path, filename: fileName),
      });
      Response response = await Dio().post(con.registerapi, data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar

    } catch (e) {
      print("Exception Caught: $e");
    }
  }
}
