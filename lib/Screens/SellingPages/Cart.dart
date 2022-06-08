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
                                      controller.remove(index);
                                    },
                                  ),
                                  Text(
                                    controller.cartItems[index].quantity
                                        .toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      // controller.add(index);
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
                    ],
                  );
                });
          }),
          SizedBox(
            height: Dimentions.height20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Proceed to Quantity Selection",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
