import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/screens/enter_otp_screen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  const EnterMobileNumberScreen({super.key});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  final mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    Text('OTP Verification'),
                    SizedBox(
                      height: Dimens.padding,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                // color: WColors.primaryColor,
                color: WColors.dimWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.padding_large),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text('Welcome Back',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),),
                    // TextFormField(

                    //   readOnly: true,
                    //   decoration: InputDecoration(hintText: '+91  INDIA',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: WColors.primaryColor))),),
                    SizedBox(height: Dimens.padding,),
                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: WColors.brightColor,
                        filled: true,
                        
                        label: Text('Enter Mobile Number',),
                          hintText: '+91',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: WColors.primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: WColors.primaryColor))),
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
                    WButton(label: 'Continue',),

                    // ClipRRect(
                    //   borderRadius:  BorderRadius.circular(20),
                    //   // height: 50,
                    //   // width: MediaQuery.of(context).size.width,
                    //   child: ElevatedButton(
                    //       onPressed: () {}, child: Text('Continue ->')),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )
        // appBar: AppBar(
        //   title: Text('Enter mobile number'),
        // ),
        // body: Column(
        //   children: [
        //     TextField(
        //       controller: mobileController,
        //       decoration: InputDecoration(hintText: 'Enter Mobile Number'),
        //     ),
        //     // ElevatedButton(onPressed: postData, child: Text('check')),
        //     ElevatedButton(onPressed: PostNumber, child: Text('continue'))
        //   ],
        // ),
        );
  }
}
