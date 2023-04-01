import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/model/send_otp_model.dart';
import 'package:wingman_machinetest/model/verify_otp_model.dart';
import 'package:wingman_machinetest/services/otp_services.dart';
import 'package:wingman_machinetest/utils/response.dart';

class OtpProvider with ChangeNotifier {
  String? _requestId;
  String? _token;
  bool? _profileExist;
  bool? _otpStatus;

  String get requestId => _requestId!;
  String get token => _token!;
  bool get profileExist => _profileExist!;
  bool get otpStatus => _otpStatus!;

  

  Future<FResponse> sendOtp({required String mobileNumber}) async {
    print('aslah : provider : sendotp');
    final response = await otpServices().sendOtp(mobileNumber: mobileNumber);
    print('sendotp response : ${response}');
    if (response.success!) {
      sendOtpModel sendOtp = response.data;
      _requestId = sendOtp.requestid;
      print('sendotp provider--------------------');
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
      print('---------------------+++++++++++++++++++++');
      print(jsonDecode(jsonEncode(response.data)));
      verifyOtpModel verifyOtp = response.data;
      print(jsonDecode(jsonEncode(verifyOtp)));

      print('verifyotp = profile exist : ');
      _profileExist = verifyOtp.profile_exists;
      _otpStatus = verifyOtp.status;
      _token = verifyOtp.jwt;
      print('verifyotp provider------otpstatus-------$_otpStatus-------');
      print('verifyotp provider------token-------$_token-------');
      notifyListeners();
    }
    return response;
  }

  Future<FResponse> profileSubmit(
      {required String name, required email, required token}) async {
    print('aslah : provider : profilesubmit');
    final response = await otpServices()
        .profileSubmit(name: name, email: email, token: token);
    print('profile submit response : ${response}');
    if (response.success!) {
      // sendOtpModel sendOtp = response.data;
      // _requestId = sendOtp.requestid;
      print('profile submit provider--------------------');
      notifyListeners();
    } else {
      print('error');
    }
    return response;
  }
}
