// ignore_for_file: file_names

import 'package:exhibition/Utils/Dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/ShoppingController.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            Center(
              child: Text(
                'Order Details',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: Dimentions.height20,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "My Cart",
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              height: Dimentions.height20,
            ),
            GetX<CartController>(builder: (controller) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(60), // Image radius
                                child: Image.network(
                                    controller.cartItems[index].pic ??
                                        "https://via.placeholder.com/350x150",
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.cartItems[index].name ?? '',
                                  style: GoogleFonts.lato(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Rs: ${controller.cartItems[index].price ?? ''}",
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          controller.remove(index);
                                        });
                                      },
                                    ),
                                    GetX<CartController>(builder: (ctrl) {
                                      return Text(
                                        ctrl.cartItems[index].quantity
                                            .toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      );
                                    }),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          controller.addtocart(
                                              controller.cartItems[index]);
                                        });
                                      },
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimentions.height10,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "Order Info",
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: Dimentions.height40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Subcost ",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    GetX<CartController>(
                                      builder: (controller) {
                                        return Text(
                                          "Rs: ${controller.totalPrice}",
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Taxes ",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "+Rs: ${(18 / 100) * Get.find<CartController>().totalPrice}",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimentions.height20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total: ",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "Rs: ${Get.find<CartController>().totalPrice + (18 / 100) * Get.find<CartController>().totalPrice}",
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimentions.height10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                          "Checkout Rs: ${Get.find<CartController>().totalPrice + (18 / 100) * Get.find<CartController>().totalPrice}",
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  });
            }),
          ]),
        ),
      ),
    );
  }
}
