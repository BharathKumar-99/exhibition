class SignupResponse {
  String? message;
  String? name;
  String? id;

  SignupResponse({this.message, this.name, this.id});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
