class Upload_Document_result {
  String? message;
  String? panFront;
  String? profilePic;
  String? aadharFront;
  String? aadharBack;

  Upload_Document_result(
      {this.message,
      this.panFront,
      this.profilePic,
      this.aadharFront,
      this.aadharBack});

  Upload_Document_result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    panFront = json['pan_front'];
    profilePic = json['profile_pic'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['pan_front'] = panFront;
    data['profile_pic'] = profilePic;
    data['aadhar_front'] = aadharFront;
    data['aadhar_back'] = aadharBack;
    return data;
  }
}
