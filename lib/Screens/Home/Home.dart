// ignore_for_file: file_names

import 'package:exhibition/Model/ProductModel.dart';
import 'package:exhibition/Model/response.dart';
import 'package:exhibition/Services/Productapi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/Widget.dart';
import '../Auth/AutoLogin.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ResponseModel user = ResponseModel();
  bool _isLoading = false;
  var _productout = "0";
  var _productin = "0";
  ProductModel productList = ProductModel();

  final String assetName = 'assets/shipment.svg';
  var username = "";

  @override
  void initState() {
    super.initState();
    _getproductapi();
    _getname();
  }

  _getname() async {
    user = await Autologin.getLogin();
    setState(() {
      username = user.name!;
    });
  }

  _getproductapi() async {
    _isLoading = true;
    await ProductApi.getProductList().then((value) => {
          setState(() {
            _productout = value!.productout!;
            _productin = value.productin!;
            _isLoading = false;
            productList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dashboard",
                      style: GoogleFonts.lato(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Welcome to the dashboard $username',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Stocks",
                        style: GoogleFonts.lato(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DetailCard(
                          _productin.toString(),
                          "Products In",
                        ),
                        DetailCard(
                          _productout.toString(),
                          'Products Out',
                        ),
                      ],
                    ),
                    Expanded(child: TabLayout()),
                  ],
                ),
              ),
            ),
          );
  }
}
