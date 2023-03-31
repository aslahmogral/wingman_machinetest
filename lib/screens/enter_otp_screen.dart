import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/enter_mobile_number_screen.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/new_user_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';

class EnterOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String requestId;
  final Function? returnMobileNumber;

  const EnterOtpScreen(
      {super.key,
      required this.requestId,
      required this.mobileNumber,
      this.returnMobileNumber});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  bool isNewUser = false;
  final otpController = TextEditingController();
  bool profileExist = false;
  // bool _keyboardVisible = false;

  postOtp() async {
    var url = Uri.parse('https://test-otp-api.7474224.xyz/verifyotp.php');
    Map data = {"request_id": widget.requestId, "code": otpController.text};
    var body = json.encode(data);

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print('responsebody : ${response.body}');
      var result = json.decode(response.body);
      print(result);

      profileExist = result['profile_exists'];
      print('aslah : profile exist $profileExist');
      if (profileExist) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewUserScreen(
                      token: result['jwt'],
                    )));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: WColors.primaryColor,
          title: Text('Enter Verification Code'),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Container(
            color: WColors.primaryColor,
            child: Column(
              children: [
                Expanded(
                    child:
                   
                        Container(
                            child: Center(
                                child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset('animation/otp.json',
                                      fit: BoxFit.fitHeight, height: 300)
                                ],
                              ),
                            )),
                          )),
                WBottomSheet(
                    child: Column(
                  children: [
                    Text(
                      'Enter OTP',
                      style: WTheme.primaryHeaderStyle,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text('We have sent otp on your number'),
                    Text('+91-${widget.mobileNumber}'),
                    SizedBox(
                      height: 16,
                    ),
                    OtpTextField(
                      numberOfFields: 6,
                      fillColor: WColors.brightColor,
                      filled: true,
                      keyboardType: TextInputType.number,
                      borderColor: WColors.primaryColor,
                      onSubmit: (code) {
                        otpController.text = code;
                        print(otpController.text);
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    WButton(
                      gradient: true,
                      label: 'Verify',
                      onPressed: postOtp,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    WButton(
                      gradient: false,
                      textColor: WColors.primaryColor,
                      buttonColor: WColors.brightColor,
                      label: 'Retry',
                      onPressed: () {
                        widget.returnMobileNumber!(widget.mobileNumber);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
        )

        // Container(
        //   color: WColors.primaryColor,
        //   child: Column(children: [
        //     Text('req id : ${widget.requestId}'),
        //     Text('enter otp'),
        //     TextField(
        //       controller: otpController,
        //       decoration: InputDecoration(hintText: 'Enter Otp'),
        //     ),
        //     ElevatedButton(onPressed: postOtp, child: Text('verify otp'))
        //   ]),
        // ),
        );
  }
}
