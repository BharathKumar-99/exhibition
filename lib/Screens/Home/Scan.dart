// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:exhibition/Screens/SellingPages/Cart.dart';
import 'package:exhibition/Services/Productapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Controller/ShoppingController.dart';
import '../../Model/ProductM.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  bool gotocart = false;
  final cartController = Get.put(CartController());
  Product _products = Product();

  void playRemoteFile() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/barcode.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    // ignore: unused_local_variable
    int result = await player.playBytes(soundbytes);
  }

  _scanBarcode() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      String barcodeScanRes;

      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.QR);
        playRemoteFile();
        ProductApi.getproduct(barcodeScanRes).then((value) => {
              if (value != null)
                {
                  _products = value,
                  Get.snackbar(
                    " ",
                    "Product Found",
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                  cartController.addtocart(_products),
                  gotocart = true,
                }
              else
                {
                  Get.snackbar(
                    " ",
                    "Product Not Found",
                    icon: const Icon(Icons.person, color: Colors.white),
                    snackPosition: SnackPosition.BOTTOM,
                  ),
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
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // ignore: unused_local_variable
      String barcodeScanRes;
      try {
        FlutterBarcodeScanner.getBarcodeStreamReceiver(
                "#ff6666", "Done", false, ScanMode.DEFAULT)!
            .listen((barcode) {
          playRemoteFile();
          ProductApi.getproduct(barcode).then((value) => {
                if (value != null)
                  {
                    _products = value,
                    Get.snackbar(
                      " ",
                      "Product Found",
                      snackPosition: SnackPosition.BOTTOM,
                    ),
                    cartController.addtocart(_products),
                    gotocart = true,
                  }
                else
                  {
                    Get.snackbar(
                      " ",
                      "Product Not Found",
                      icon: const Icon(Icons.person, color: Colors.white),
                      snackPosition: SnackPosition.BOTTOM,
                    ),
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
          IconButton(
            icon:
                const Icon(Icons.shopping_cart, color: Colors.black, size: 30),
            onPressed: () {
              Get.to(() => const MyCart());
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Scan Products",
          style: GoogleFonts.lato(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _scanBarcode, child: const Text("Scan")),
            ElevatedButton(
                onPressed: _scanBarcodeCont,
                child: const Text("Scan Multiple")),
          ],
        ),
      ),
    );
  }
}
