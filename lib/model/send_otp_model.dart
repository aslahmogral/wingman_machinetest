/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class sendOtpModel {
    bool? status;
    String? response;
    String? requestid;

    sendOtpModel({this.status, this.response, this.requestid}); 

    sendOtpModel.fromJson(Map<String, dynamic> json) {
        status = json['status'];
        response = json['response'];
        requestid = json['request_id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['status'] = status;
        data['response'] = response;
        data['request_id'] = requestid;
        return data;
    }

    
}