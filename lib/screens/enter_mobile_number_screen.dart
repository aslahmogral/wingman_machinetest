import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/enter_otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';
import 'package:lottie/lottie.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  const EnterMobileNumberScreen({super.key});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  final mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _keyboardVisible = false;

  PostNumber() async {
    // print(mobileController.text);
    var url = 'https://test-otp-api.7474224.xyz/sendotp.php';
    Map data = {"mobile": mobileController.text};
    var body = json.encode(data);
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      var result = json.decode(response.body);
      print(result);
      print(result['request_id']);
      // print('request id :${}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EnterOtpScreen(
                    requestId: result['request_id'],
                  )));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        body: Container(
      color: WColors.primaryColor,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _keyboardVisible
                        ? SizedBox()
                        : Column(
                            children: [
                              Text('OTP Verification'),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              Lottie.asset('animation/mobilenumber.json',fit: BoxFit.cover,height: 300)
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          WBottomSheet(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Dimens.padding,
                  ),
                  WTextFormField(
                    hintText: '+91',
                    label: 'Enter Mobile Number',
                    textEditingController: mobileController,
                    textInputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: Dimens.padding,
                  ),
                  Text('We will send you one time password (OTP)'),
                  SizedBox(
                    height: Dimens.padding,
                  ),
                  Text('Carrier rates may apply'),
                  SizedBox(
                    height: Dimens.padding,
                  ),
                  WButton(
                    label: 'Continue',
                    onPressed: PostNumber,
                  ),
                  SizedBox(height: 40,)
                ],
              ),
            ),
          )
        ],
      ),
    )

        // ),
        );
  }
}
