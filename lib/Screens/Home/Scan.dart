import 'dart:typed_data';

import 'package:exhibition/Screens/SellingPages/Cart.dart';
import 'package:exhibition/Services/Productapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    int result = await player.playBytes(soundbytes);
  }

  _scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      playRemoteFile();
      ProductApi.getproduct(barcodeScanRes).then((value) => {
            if (value != "")
              {
                _products = value,
                Get.snackbar(
                  " ",
                  "Product Found",
                  snackPosition: SnackPosition.BOTTOM,
                ),
                cartController.cartItems
                        .where((element) => element.name == _products.name)
                        .toList()
                        .isEmpty
                    ? cartController.cartItems.add(_products)
                    : //increment the quantity of the product
                    cartController.cartItems
                        .where((element) => element.name == _products.name)
                        .toList()
                        .forEach((element) {
                        element.quantity = element.quantity! + 1;
                        print("object");
                      }),
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
  }

  _scanBarcodeCont() async {
    String barcodeScanRes;
    try {
      FlutterBarcodeScanner.getBarcodeStreamReceiver(
              "#ff6666", "Done", false, ScanMode.DEFAULT)!
          .listen((barcode) {
        playRemoteFile();
        print(barcode);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            ElevatedButton(
                onPressed: () => Get.to(() => const MyCart()),
                child: const Text("Go To Cart"))
          ],
        ),
      ),
    );
  }
}
