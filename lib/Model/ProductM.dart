// ignore_for_file: file_names

class ProductApiModel {
  String? status;
  List<Product>? product;

  ProductApiModel({this.status, this.product});

  ProductApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['Product'] != null) {
      product = <Product>[];
      json['Product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (product != null) {
      data['Product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? barcode;
  String? pic;
  int? price;
  String? describption;
  int? quantity;

  Product(
      {this.id,
      this.name,
      this.barcode,
      this.pic,
      this.price,
      this.describption,
      this.quantity});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    barcode = json['Barcode'];
    pic = json['Pic'];
    price = json['Price'];
    describption = json['Describption'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['Barcode'] = barcode;
    data['Pic'] = pic;
    data['Price'] = price;
    data['Describption'] = describption;
    data['quantity'] = quantity;
    return data;
  }
}
