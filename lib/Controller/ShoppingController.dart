import 'package:exhibition/Model/ProductM.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.price!);

  addtocart(Product product) {
    if (cartItems.contains(product)) {
      cartItems.remove(product);
      print("removed");
    } else {
      cartItems.add(product);
    }
  }

  remove(int i) {
    cartItems.removeAt(i);
  }
}
