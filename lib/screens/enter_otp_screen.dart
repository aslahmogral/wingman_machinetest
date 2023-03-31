import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/new_user_screen.dart';
import 'package:wingman_machinetest/utils/colors.dart';

class EnterOtpScreen extends StatefulWidget {
  final String requestId;
  const EnterOtpScreen({super.key, required this.requestId});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  bool isNewUser = false;
  final otpController = TextEditingController();
  bool profileExist = false;
  bool _keyboardVisible = false;


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
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: WColors.primaryColor,
          title: Text('Enter Verification Code'),
        ),
        body: Container(
          color: WColors.primaryColor,
          child: Column(
            children: [
              Expanded(
                  child:_keyboardVisible ? SizedBox() : Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Lottie.asset('animation/otp.json')
                    ],
                  )
                ),
              )),
              WBottomSheet(
                  child: Column(
                children: [
                  Text('We have sent otp on your number'),
                  SizedBox(
                    height: 16,
                  ),
                  WTextFormField(
                      label: 'Enter Otp',
                      textEditingController: otpController,
                      textInputType: TextInputType.number),
                  SizedBox(
                    height: 16,
                  ),
                  WButton(
                    label: 'Verify',
                    onPressed: postOtp,
                  )
                ],
              ))
            ],
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
