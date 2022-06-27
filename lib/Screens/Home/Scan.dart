import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart';
import 'package:exhibition/Model/ProductModel.dart';
import 'package:exhibition/Services/Productapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Controller/ShoppingController.dart';
import '../../Utils/Dimentions.dart';
import '../SellingPages/Cart.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final cartController = Get.put(CartController());

  void playRemoteFile() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/barcode.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    // ignore: unused_local_variable
    int result = await player.playBytes(soundbytes);
    setState(() {});
  }

  _scanBarcode() async {
    var status = await Permission.camera.status;
    ProductModel products = ProductModel();
    if (status.isGranted) {
      String barcodeScanRes;

      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.QR);
        playRemoteFile();
        await ProductApi.getProduct(int.parse(barcodeScanRes)).then((value) {
          if (value != null) {
            products = value;
            Get.snackbar(
              " ",
              "Product Found",
              snackPosition: SnackPosition.BOTTOM,
            );

            cartController.addtocart(ProductModel(
                name: products.name,
                pic: products.pic,
                price: products.price,
                description: products.description,
                barcode: products.barcode,
                quantity: 1));
          } else {
            Get.snackbar(
              " ",
              "Product Not Found",
              icon: const Icon(Icons.error, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        });
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
    } else {
      await Permission.camera.request();
    }
  }

  _scanBarcodeCont() async {
    ProductModel products = ProductModel();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // ignore: unused_local_variable
      String barcodeScanRes;
      try {
        FlutterBarcodeScanner.getBarcodeStreamReceiver(
                "#ff6666", "Done", false, ScanMode.DEFAULT)!
            .listen((barcode) async {
          playRemoteFile();
          await ProductApi.getProduct(int.parse(barcode)).then((value) {
            if (value != null) {
              products = value;
              Get.snackbar(
                " ",
                "Product Found",
                snackPosition: SnackPosition.BOTTOM,
              );

              cartController.addtocart(ProductModel(
                  name: products.name,
                  pic: products.pic,
                  price: products.price,
                  description: products.description,
                  barcode: products.barcode,
                  quantity: 1));
            } else {
              Get.snackbar(
                " ",
                "Product Not Found",
                icon: const Icon(Icons.error, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        });
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
    } else {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Badge(
                  badgeContent: GetX<CartController>(
                    builder: (controller) {
                      return Text(
                        "${controller.totalitem}",
                      );
                    },
                  ),
                  child: IconButton(
                      onPressed: () => Get.to(() => const MyCart()),
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.blue,
                        size: 35,
                      )),
                ),
              )
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Scan",
                style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _scanBarcode(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Scan",
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )),
              SizedBox(height: Dimentions.height10),
              ElevatedButton(
                  onPressed: () => _scanBarcodeCont(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Scan Multiple",
                      style: GoogleFonts.lato(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )),
            ],
          ),
        ));
  }
}
