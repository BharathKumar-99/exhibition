import 'package:exhibition/Screens/Home/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Orderplaced extends StatefulWidget {
  const Orderplaced({Key? key}) : super(key: key);

  @override
  State<Orderplaced> createState() => _OrderplacedState();
}

class _OrderplacedState extends State<Orderplaced> {
  loader() async {
    await Future.delayed(const Duration(seconds: 5))
        .then((value) => Get.offAll(const Home()));
  }

  @override
  void initState() {
    super.initState();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/order_placed.json'),
            Text(
              "Order Placed",
              style: GoogleFonts.lato(
                  fontSize: 50,
                  color: Colors.blue,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
