import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/model/send_otp_model.dart';
import 'package:wingman_machinetest/model/verify_otp_model.dart';
import 'package:wingman_machinetest/services/otp_services.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/response.dart';

class OtpProvider with ChangeNotifier {
  String? _requestId;
  bool? _profileExist;
  bool? _otpStatus;

  String get requestId => _requestId!;
  bool get profileExist => _profileExist!;
  bool get otpStatus => _otpStatus!;

  

  Future<FResponse> sendOtp({required String mobileNumber}) async {
    final response = await otpServices().sendOtp(mobileNumber: mobileNumber);
    if (response.success!) {
      sendOtpModel sendOtp = response.data;
      _requestId = sendOtp.requestid;
      notifyListeners();
    } else {
      print('error');
    }
    return response;
  }

  Future<FResponse> verfyOtp({required String requestId, required otp}) async {
    print('aslah : provider : sendotp');
    final response =
        await otpServices().verifyOtp(requestId: requestId, otp: otp);
    if (response.success!) {
      print(jsonDecode(jsonEncode(response.data)));
      verifyOtpModel verifyOtp = response.data;
      print(jsonDecode(jsonEncode(verifyOtp)));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.token_key, verifyOtp.jwt.toString());

      _profileExist = verifyOtp.profile_exists;
      _otpStatus = verifyOtp.status;
      notifyListeners();
    }
    return response;
  }

 

  Future<FResponse> profileSubmit(
      {required String name, required email, required token}) async {
    final response = await otpServices()
        .profileSubmit(name: name, email: email, token: token);
    if (response.success!) {
      print('profile submit provider--------------------');
      notifyListeners();
    } else {
      print('error');
    }
    return response;
  }
}
