import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wingman_machinetest/screens/enter_otp_screen.dart';
import 'package:http/http.dart' as http;

class EnterMobileNumberScreen extends StatefulWidget {
  const EnterMobileNumberScreen({super.key});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  final mobileController = TextEditingController();

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
      appBar: AppBar(
        title: Text('Enter mobile number'),
      ),
      body: Column(
        children: [
          TextField(
            controller: mobileController,
            decoration: InputDecoration(hintText: 'Enter Mobile Number'),
          ),
          // ElevatedButton(onPressed: postData, child: Text('check')),
          ElevatedButton(onPressed: PostNumber, child: Text('continue'))
        ],
      ),
    );
  }
}
