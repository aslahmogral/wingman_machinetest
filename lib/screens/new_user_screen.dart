import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/apptheme.dart';
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


    return Scaffold(
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
                    child: Container(
                  child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                        Lottie.asset('animation/newuser.json',
                            fit: BoxFit.contain, height: 300)
                                        ],
                                      ),
                      )),
                )),
                WBottomSheet(
                    child: Column(
                  children: [
                    Text('Welcome Back',style: WTheme.primaryHeaderStyle2,),
                    SizedBox(height: 16,),
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
                    WButton(label: 'Submit',onPressed: postNameAndEmail,gradient: true,)
                  ],
                ))
              ],
            ),
          ),
        )

      
        );
  }
}
