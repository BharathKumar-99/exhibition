import 'dart:developer';

import 'package:exhibition/Model/VenderModel.dart';
import 'package:exhibition/Services/complaint.dart';
import 'package:exhibition/Utils/Dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MainScreen.dart';

class RaiseComplaints extends StatefulWidget {
  String email;
  VenderModel vendersold;
  int index;

  RaiseComplaints(this.vendersold, this.email, this.index, {Key? key})
      : super(key: key);

  @override
  State<RaiseComplaints> createState() => _RaiseComplaintsState();
}

class _RaiseComplaintsState extends State<RaiseComplaints> {
  TextEditingController controller = TextEditingController();

  _sendComplaints(String email, VenderModel vendersold, int index) async {
    await ComplaintApi.sendComplaints(email, vendersold, index, controller.text)
        .then((value) {
      log(value);
      if (value == "Complaint registered") {
        Get.snackbar(
          "success",
          "Complaint registered",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      Get.off(() => const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Raise Complaints"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "Orderid:${widget.vendersold.sold![widget.index].orderid!}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(fontSize: 20),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Sold To: ${widget.vendersold.sold![widget.index].soldto!}",
                style: GoogleFonts.lato(fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Products:-",
                style: GoogleFonts.lato(fontSize: 25),
              ),
            ),
            SizedBox(
              height: Dimentions.height150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      widget.vendersold.sold![widget.index].products!.length,
                  itemBuilder: (context, indexs) {
                    return Card(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.network(widget.vendersold
                            .sold![widget.index].products![indexs].pic!),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: Dimentions.height200,
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: 'Write the Complaint'),
                  maxLines: null,
                  expands: true,
                  controller: controller,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => _sendComplaints(
                    widget.email, widget.vendersold, widget.index),
                child: const Text("Submit Complaint")),
          ],
        ),
      ),
    );
  }
}
