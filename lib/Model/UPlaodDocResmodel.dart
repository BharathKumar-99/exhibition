class Upload_Document_result {
  String? message;
  String? panFront;
  String? panBack;
  String? aadharFront;
  String? aadharBack;

  Upload_Document_result(
      {this.message,
      this.panFront,
      this.panBack,
      this.aadharFront,
      this.aadharBack});

  Upload_Document_result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    panFront = json['pan_front'];
    panBack = json['pan_back'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['pan_front'] = panFront;
    data['pan_back'] = panBack;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    return data;
  }
}
