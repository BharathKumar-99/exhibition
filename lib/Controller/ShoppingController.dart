// ignore_for_file: file_names

import 'package:exhibition/Model/ProductM.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  int get totalPrice => _totalPrice();

  int _totalPrice() {
    int total = 0;
    for (var item in cartItems) {
      {
        total += (item.price! * item.quantity!);
      }
    }
    return total;
  }

  addtocart(Product product) {
    cartItems.where((element) => element.name == product.name).toList().isEmpty
        ? cartItems.add(product)
        : //increment the quantity of the product
        cartItems
            .where((element) => element.name == product.name)
            .toList()
            .forEach((element) {
            element.quantity = element.quantity! + 1;
          });
  }

  remove(int i) {
    if (cartItems[i].quantity! > 1) {
      cartItems[i].quantity = cartItems[i].quantity! - 1;
    } else {
      cartItems.removeAt(i);
    }
  }
}
