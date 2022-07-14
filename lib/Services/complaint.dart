import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exhibition/Model/VenderModel.dart';
import 'package:exhibition/Utils/Connections.dart';
import 'package:http/http.dart' as http;

class ComplaintApi {
  static var client = http.Client();
  static var dio = Dio();
  static sendComplaints(
      String email, VenderModel vendersold, int index, String text) async {
    var body = {
      "email": email,
      "orderid": vendersold.sold![index].orderid,
      "cemail": vendersold.sold![index].soldto,
      "complaint": text,
      "product": vendersold.sold![index].products
    };
    var returnData = "failed";
    try {
      await dio.post(con.sendcomplaints, data: body).then((value) => {
            if (value.data == "Complaint Registered")
              {
                returnData = "Complaint registered",
              }
          });
    } catch (e) {
      log(e.toString());
    }
    return returnData;
  }
}
