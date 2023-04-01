/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class verifyOtpModel {
  bool? status;
  bool? profile_exists;
  String? jwt;

  verifyOtpModel({this.status, this.profile_exists, this.jwt});

  verifyOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profile_exists = json['profile_exists'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['profile_exists'] = profile_exists;
    data['jwt'] = jwt;
    return data;
  }
}
