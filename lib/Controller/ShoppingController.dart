// ignore_for_file: file_names

import 'package:get/get.dart';

import '../Model/ProductModel.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;

  int get totalPrice => _totalPrice();
  int get totalitem => _totalcount();

  int _totalcount() {
    int items = 0;
    for (var item in cartItems) {
      {
        items++;
      }
    }
    return items;
  }

  int _totalPrice() {
    int total = 0;
    for (var item in cartItems) {
      {
        if (item.price != null && item.quantity != null) {
          total += (item.price! * item.quantity!);
        }
      }
    }
    return total;
  }

  addtocart(ProductModel product) {
    cartItems
            .where((element) => element.barcode == product.barcode)
            .toList()
            .isEmpty
        ? cartItems.add(product)
        : //increment the quantity of the product
        cartItems
            .where((element) => element.barcode == product.barcode)
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
