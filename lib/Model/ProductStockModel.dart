class ProductStockModel {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? panFront;
  String? panBack;
  String? aadharFront;
  String? aadharBack;
  String? status;
  int? productin;
  int? productout;

  ProductStockModel(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.panFront,
      this.panBack,
      this.aadharFront,
      this.aadharBack,
      this.status,
      this.productin,
      this.productout});

  ProductStockModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    panFront = json['pan_front'];
    panBack = json['pan_back'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    status = json['status'];
    productin = json['productin'];
    productout = json['productout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['pan_front'] = panFront;
    data['pan_back'] = panBack;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    data['status'] = status;
    data['productin'] = productin;
    data['productout'] = productout;
    return data;
  }
}
