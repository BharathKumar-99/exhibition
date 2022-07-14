import 'package:exhibition/Model/VenderModel.dart';
import 'package:exhibition/Model/response.dart';
import 'package:exhibition/Screens/Home/raiseordercomplaint.dart';
import 'package:exhibition/Services/Productapi.dart';
import 'package:exhibition/Utils/Dimentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Auth/AutoLogin.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool loading = true;
  var venderlist = VenderModel();
  var user = ResponseModel();
  _loaduser() async {
    await ProductApi.getvenderorders(user.email!).then((orders) => {
          venderlist = orders[0],
        });
    setState(() {
      loading = false;
    });
  }

  _raisecomplaint(VenderModel vendersold, String email, int index) {
    Get.to(() => RaiseComplaints(vendersold, email, index));
  }

  _getname() async {
    user = await Autologin.getLogin();
    _loaduser();
  }

  @override
  void initState() {
    _getname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : venderlist == VenderModel()
              ? const Center(
                  child: Text("No Orders found"),
                )
              : ListView.builder(
                  itemCount: venderlist.sold!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Orderid:${venderlist.sold![index].orderid!}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(fontSize: 16),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Sold To: ${venderlist.sold![index].soldto!}",
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Products:-",
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimentions.height150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: venderlist
                                          .sold![index].products!.length,
                                      itemBuilder: (context, indexs) {
                                        return Card(
                                          child: SizedBox(
                                            height: Dimentions.height80,
                                            width: Dimentions.width80,
                                            child: Image.network(venderlist
                                                .sold![index]
                                                .products![indexs]
                                                .pic!),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 15,
                            child: ElevatedButton(
                                onPressed: () => _raisecomplaint(
                                    venderlist, user.email!, index),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text("Raise Complaints"))),
                      ],
                    );
                  }),
    );
  }
}
