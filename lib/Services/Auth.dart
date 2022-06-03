import 'dart:convert';
import 'dart:io';
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
  static signup(
      String email,
      String password,
      String name,
      String phone,
      File? panFront,
      File? panBack,
      File? aadharFront,
      File? aadharBack) async {
//upload image to server

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

    var response = await request.send();

    return response.stream.bytesToString();
  }
}
