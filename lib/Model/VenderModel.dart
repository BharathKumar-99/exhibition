class VenderModel {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? panFront;
  String? profilePic;
  String? aadharFront;
  String? aadharBack;
  String? status;
  bool? active;
  int? productin;
  int? productout;
  List<Products>? products;
  List<Sold>? sold;

  VenderModel(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.panFront,
      this.profilePic,
      this.aadharFront,
      this.aadharBack,
      this.status,
      this.active,
      this.productin,
      this.productout,
      this.products,
      this.sold});

  VenderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    panFront = json['pan_front'];
    profilePic = json['profile_pic'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    status = json['status'];
    active = json['active'];
    productin = json['productin'];
    productout = json['productout'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['sold'] != null) {
      sold = <Sold>[];
      json['sold'].forEach((v) {
        sold!.add(Sold.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['pan_front'] = panFront;
    data['profile_pic'] = profilePic;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    data['status'] = status;
    data['active'] = active;
    data['productin'] = productin;
    data['productout'] = productout;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (sold != null) {
      data['sold'] = sold!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sold {
  String? orderid;
  String? soldto;
  String? date;
  List<Products>? products;

  Sold({this.orderid, this.soldto, this.date, this.products});

  Sold.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    soldto = json['soldto'];
    date = json['date'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderid'] = orderid;
    data['soldto'] = soldto;
    data['date'] = date;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? nId;
  String? name;
  int? barcode;
  String? pic;
  int? price;
  String? description;
  int? quantity;

  Products(
      {this.nId,
      this.name,
      this.barcode,
      this.pic,
      this.price,
      this.description,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    name = json['Name'];
    barcode = json['Barcode'];
    pic = json['Pic'];
    price = json['Price'];
    description = json['Description'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = nId;
    data['Name'] = name;
    data['Barcode'] = barcode;
    data['Pic'] = pic;
    data['Price'] = price;
    data['Description'] = description;
    data['Quantity'] = quantity;
    return data;
  }
}
