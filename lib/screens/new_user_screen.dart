import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/colors.dart';

class NewUserScreen extends StatefulWidget {
  final String token;
  const NewUserScreen({super.key, required this.token});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
 bool _keyboardVisible = false;


  postNameAndEmail() async {
    var url = Uri.parse('https://test-otp-api.7474224.xyz/profilesubmit.php');
    Map data = {"name": nameController.text, "email": emailController.text};
    var body = json.encode(data);

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json", "Token": widget.token},
          body: body);
      print('responsebody : ${response.body}');
      var result = json.decode(response.body);
      print(result);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                    Lottie.asset('animation/newuser.json',
                        fit: BoxFit.contain, height: 300)
                  ],
                )),
              )),
              WBottomSheet(
                  child: Column(
                children: [
                  Text('Welcom Back'),
                  Text('Enter your details below'),
                  SizedBox(
                    height: 16,
                  ),
                  WTextFormField(
                    textEditingController: nameController,
                    label: 'Enter Name',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  WTextFormField(
                    textEditingController: emailController,
                    label: 'Enter Email',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  WButton(label: 'Submit',onPressed: postNameAndEmail,)
                ],
              ))
            ],
          ),
        )

        // appBar: AppBar(
        //     elevation: 0.0,
        //   backgroundColor: WColors.primaryColor,
        //   title: Text('Welcome'),
        // ),
        // body:

        //  Column(
        //   children: [
        //     Text('welcom looks like your are new here'),
        //     TextField(
        //       controller: nameController,
        //       decoration: InputDecoration(hintText: 'Enter Name'),
        //     ),
        //     TextField(
        //       controller: emailController,
        //       decoration: InputDecoration(hintText: 'Enter Email'),
        //     ),
        //     ElevatedButton(onPressed: postNameAndEmail, child: Text('submit'))
        //   ],
        // ),
        );
  }
}
