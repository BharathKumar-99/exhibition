import 'dart:convert';

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
    http.Response response = await http.get(Uri.parse(con.getweeksales));
    return response.body;
  }
}
