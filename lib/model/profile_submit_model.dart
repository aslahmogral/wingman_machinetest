/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class ProfileSubmitModel {
    bool? status;
    String? response;

    ProfileSubmitModel({this.status, this.response}); 

    ProfileSubmitModel.fromJson(Map<String, dynamic> json) {
        status = json['status'];
        response = json['response'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['status'] = status;
        data['response'] = response;
        return data;
    }
}

