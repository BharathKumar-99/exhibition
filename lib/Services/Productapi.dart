// ignore_for_file: file_names

import 'dart:convert';

import 'package:exhibition/Model/ProductM.dart';
import 'package:exhibition/Model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:exhibition/Utils/Connections.dart';

class ProductApi {
  static var client = http.Client();

  //get product list
  static Future<ProductModel?> getProductList() async {
    ProductModel productList = ProductModel();
    try {
      await client.post(Uri.parse(con.productcountapi)).then((value) => {
            if (value.statusCode == 200)
              {
                productList = ProductModel.fromJson(json.decode(value.body)),
              }
            else
              {productList = ProductModel()}
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

  static Future<Product?> getproduct(String barcode) async {
    var product = Product();
    http.Response response = await http.post(Uri.parse(con.getproduct), body: {
      "name": barcode,
    });

    if (response.statusCode == 200) {
      for (final item in jsonDecode(response.body)) {
        product = Product.fromJson(item);
      }
      if (product.name == null) {
        return null;
      }
      return product;
    } else {
      Get.snackbar(
        "Error",
        "product not found",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }
}
