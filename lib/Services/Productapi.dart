import 'dart:convert';
import 'dart:developer';

import 'package:exhibition/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exhibition/Utils/Connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/ShoppingController.dart';
import '../Model/ProductStockModel.dart';

class ProductApi {
  static var client = http.Client();

  //get product list
  static getProductList() async {
    ProductStockModel productList = ProductStockModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(prefs.getString('user')!));

    var id = data['email'];
    print(id);
    try {
      await http.post(Uri.parse(con.productcountapi), body: {'email': id}).then(
          (value) => {
                print(value.body),
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
      print(response.body);
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
        icon: const Icon(Icons.person, color: Colors.white),
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
            log(value.body),
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
    var reqdata = {
      "name": name,
      "email": email,
      "phone": phone,
      "solditem": [
        {ProductModel().toJson()}
      ],
      "totalprice": Get.find<CartController>().totalPrice +
          (18 / 100) * Get.find<CartController>().totalPrice
    };

    var response = http
        .post(Uri.parse(con.sellproduct), body: reqdata)
        .then((value) => {log(value.body)});
  }
}
