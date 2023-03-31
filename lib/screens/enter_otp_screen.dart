import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/new_user_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:pinput/pinput.dart';

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
  bool isOtpCorrect = true;

  final _formKey = GlobalKey<FormState>();

  // bool _keyboardVisible = false;

  postOtp() async {
    var url = Uri.parse('https://test-otp-api.7474224.xyz/verifyotp.php');
    Map data = {"request_id": widget.requestId, "code": otpController.text};
    var body = json.encode(data);

    bool isValidated = _formKey.currentState!.validate();

    if (isValidated) {
      try {
        var response = await http.post(url,
            headers: {"Content-Type": "application/json"}, body: body);
        print('responsebody : ${response.body}');
        var responseBody = json.decode(response.body);
        String invalidOtp = 'invalid otp';
        String responseOtp = responseBody['response'];
        print('===========');
        print(responseBody['response']);
        if (responseOtp == invalidOtp) {
          print('++++++++++++++++++++');
          isOtpCorrect = false;
        }

        profileExist = responseBody['profile_exists'];
        print('aslah : profile exist $profileExist');

        if (profileExist) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewUserScreen(
                        token: responseBody['jwt'],
                      )));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: WTheme.primaryGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text('Enter Verification Code'),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  AnimationContainer(lottie: 'animation/otp.json'),
                  Positioned(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: WBottomSheet(
                          child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                              Pinput(
                                validator: (code) {
                                  if (code!.isEmpty) {
                                    return 'plz enter code to continue';
                                  } else if (isOtpCorrect == false) {
                                    return 'entered otp is wrong';
                                  }
                                  return null;
                                },
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                controller: otpController,
                                length: 6,
                                defaultPinTheme: PinTheme(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: WColors.primaryColor))),
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
                                  widget
                                      .returnMobileNumber!(widget.mobileNumber);
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
