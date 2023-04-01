import 'dart:convert';
// import 'dart:io';

import 'package:http/http.dart';
import 'package:wingman_machinetest/services/http_exception.dart';

class ServiceHelper {
  static Uri get sendOtpUrl {
    Uri sendOtp = Uri.parse('https://test-otp-api.7474224.xyz/sendotp.php');
    return sendOtp;
  }

  static Uri get verifyOtpUrl {
    Uri sendOtp = Uri.parse('https://test-otp-api.7474224.xyz/verifyotp.php');
    return sendOtp;
  }

  static Uri get profileSubmitUrl {
    Uri profileSubmit = Uri.parse('https://test-otp-api.7474224.xyz/profilesubmit.php');
    return profileSubmit;
  }

  static Future<dynamic> getResponseBody(Response response) async {
    if (response.statusCode < 200 || response.statusCode > 299) {
      final message =
          json.decode(response.body)['error'] ?? "Unknown exception";
      throw HttpException(message: message, statusCode: response.statusCode);
    }
    return jsonDecode(response.body);
  }
}
