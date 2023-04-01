import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/model/send_otp_model.dart';
import 'package:wingman_machinetest/model/verify_otp_model.dart';
import 'package:wingman_machinetest/services/service_helper.dart';
import 'package:wingman_machinetest/utils/headers.dart';

import 'package:wingman_machinetest/utils/response.dart';

class otpServices {
  Future<FResponse> sendOtp({required String mobileNumber}) async {
    try {
      final response = await http.post(
        ServiceHelper.sendOtpUrl,
        headers: Headers().httpHeadersWithoutToken(),
        body: jsonEncode({"mobile": mobileNumber}),
      );

      final responseBody = await ServiceHelper.getResponseBody(response);

      var decoded = sendOtpModel.fromJson(responseBody);
      print('success');
      print(decoded.requestid);
      return FResponse.success(data: decoded);
    } catch (e) {
      print(e);
      return FResponse.error(error: e.toString());
    }
  }

  Future<FResponse> verifyOtp({required String requestId, required otp}) async {
    try {
      final response = await http.post(
        ServiceHelper.verifyOtpUrl,
        headers: Headers().httpHeadersWithoutToken(),
        body: jsonEncode({"request_id": requestId, "code": otp}),
      );

      final responseBody = await ServiceHelper.getResponseBody(response);
      print('verifyotp : response : $responseBody >>>>>>>>>>>>>>>');

      var decoded = verifyOtpModel.fromJson(responseBody);
      print(decoded.profile_exists);
      return FResponse.success(data: decoded);
    } catch (e) {
      print(e);
      return FResponse.error(error: e.toString());
    }
  }
}
