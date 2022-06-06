class ResponseModel {
  String? name;
  String? response;
  String? email;
  String? phone;
  String? status;

  ResponseModel(
      {this.name, this.response, this.email, this.phone, this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    response = json['response'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['response'] = response;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}
