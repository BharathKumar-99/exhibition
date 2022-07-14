import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:exhibition/Model/ProductModel.dart';
import 'package:exhibition/Model/VenderModel.dart';
import 'package:exhibition/Model/response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exhibition/Utils/Connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/ShoppingController.dart';
import '../Model/ProductStockModel.dart';
import '../Screens/Auth/AutoLogin.dart';
import '../Screens/SellingPages/Order_Placed.dart';

class ProductApi {
  static var client = http.Client();
  static var dio = Dio();

  //get product list
  static getProductList() async {
    ProductStockModel productList = ProductStockModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(prefs.getString('user')!));

    var id = data['email'];

    try {
      await http.post(Uri.parse(con.productcountapi), body: {'email': id}).then(
          (value) => {
                if (value.statusCode == 200)
                  {
                    productList =
                        ProductStockModel.fromJson(json.decode(value.body)),
                  }
                else
                  {productList = ProductStockModel()}
              });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    return productList;
  }

  static Future<String> getweeklist() async {
    String weeklist = "";
    try {
      http.Response response = await http.get(Uri.parse(con.getweeksales));
      weeklist = response.body;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return weeklist;
  }

  static Future<String> getdaylist() async {
    var responsestring = "";
    try {
      http.Response response = await http.get(Uri.parse(con.getdaysales));
      responsestring = response.body;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return responsestring;
  }

  static Future<String> getmonthlist() async {
    var responsestring = "";
    try {
      http.Response response = await http.get(Uri.parse(con.getmonthsales));
      responsestring = response.body;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return responsestring;
  }

  static Future<String> getyearlist() async {
    var responsestring = "";
    try {
      http.Response response = await http.get(Uri.parse(con.getyearsales));
      responsestring = response.body;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return responsestring;
  }

  static getProduct(int barcode) async {
    ProductModel? products = ProductModel();

    try {
      var responsestring = await http.post(
        Uri.parse(con.getproduct),
        body: {
          'Barcode': barcode.toString(),
        },
      ).then((value) => {
            if (value.statusCode == 200)
              {
                if (value.body == "Something Went Wrong")
                  {products = null}
                else
                  {
                    products = ProductModel.fromJson(json.decode(value.body)),
                  }
              }
            else
              {products = null}
          });
    } catch (e) {
      log("error");
    }

    return products;
  }

  static soldproduct(String name, String email, String phone) async {
    var jsonlist = [];
    var result = "";
    for (var item in Get.find<CartController>().cartItems) {
      jsonlist.add(item.toJson());
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ResponseModel user = ResponseModel();
    user = await Autologin.getLogin();
    var vemail = user.email;

    var reqdata = {
      "name": name,
      "vemail": vemail,
      "email": email,
      "phone": phone,
      "solditem": jsonlist,
      "totalprice": Get.find<CartController>().totalPrice +
          (18 / 100) * Get.find<CartController>().totalPrice
    };
    try {
      var response =
          await dio.post(con.sellproduct, data: reqdata).then((value) => {
                if (value.data == "Mailsent")
                  {result = value.data, Get.off(() => const Orderplaced())}
                else
                  {
                    result = "error",
                    Get.snackbar(
                      "Error",
                      "Something went wrong",
                      icon: const Icon(Icons.error, color: Colors.white),
                      snackPosition: SnackPosition.BOTTOM,
                    )
                  },
              });
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  static getvenderorders(String email) async {
    List<VenderModel> model = [];
    try {
      await http.post(
        Uri.parse(con.getvenderorders),
        body: {'email': email},
      ).then((val) => {
            for (final item in json.decode(val.body))
              {
                model.add(VenderModel.fromJson(item)),
              }
          });
    } catch (e) {
      print(e.toString());
    }
    return model;
  }
}
