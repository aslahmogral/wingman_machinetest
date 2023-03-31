import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/enter_otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';
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
  String mobileNumber = '';

  enterNumber(String mobileNumber) async {
    // print(mobileController.text);
    var url = 'https://test-otp-api.7474224.xyz/sendotp.php';
    Map data = {"mobile": mobileNumber};
    var body = json.encode(data);
    try {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        print('passed');
        var result = json.decode(response.body);
        print(result);
        print(result['request_id']);
        bool isValidated = _formKey.currentState!.validate();
        if (isValidated) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterOtpScreen(
                        returnMobileNumber: (value) {
                          mobileNumber = value;
                        },
                        requestId: result['request_id'],
                        mobileNumber: mobileController.text,
                      )));
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: WTheme.primaryGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  AnimationContainer(lottie: 'animation/mobilenumber.json'),
                  Positioned(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: WBottomSheet(
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Enter Your Phone Number',
                                  style: WTheme.primaryHeaderStyle,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                WTextFormField(
                                  hintText: '+91 India',
                                  label: 'Enter Mobile Number',
                                  textEditingController: mobileController,
                                  textInputType: TextInputType.phone,
                                  validator: (value) {
                                    return regExpMobileNumber(value);
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                    'We will send you one time \n\t\t\t\t\t\t\t password (OTP)'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Carrier rates may apply',
                                  style: TextStyle(color: WColors.primaryColor),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                WButton(
                                  gradient: true,
                                  label: 'CONTINUE',
                                  onPressed: () =>enterNumber(mobileController.text),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )

          // ),
          ),
    );
  }

  String? regExpMobileNumber(String? value) {
    if (value!.isEmpty) {
      return 'Mobile number is empty';
    } else if (!RegExp(
            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
        .hasMatch(value)) {
      return 'invalid mobile number';
    }
    return null;
  }
}
