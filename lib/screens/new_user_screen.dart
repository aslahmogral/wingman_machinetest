import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_machinetest/utils/apptheme.dart';

class NewUserScreen extends StatefulWidget {
  final String token;
  const NewUserScreen({super.key, required this.token});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  postNameAndEmail() async {
    var url = Uri.parse('https://test-otp-api.7474224.xyz/profilesubmit.php');
    Map data = {"name": nameController.text, "email": emailController.text};
    var body = json.encode(data);

    bool isValidated = _formKey.currentState!.validate();
    if (isValidated) {
      try {
        var response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              "Token": widget.token
            },
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
            title: Text('Enter Verification Code'),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  AnimationContainer(lottie: 'animation/newuser.json'),
                  
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
                                'Welcome Back',
                                style: WTheme.primaryHeaderStyle2,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text('Enter your details below'),
                              SizedBox(
                                height: 16,
                              ),
                              WTextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Your Name';
                                  }
                                  return null;
                                },
                                textEditingController: nameController,
                                label: 'Enter Name',
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              WTextFormField(
                                textEditingController: emailController,
                                label: 'Enter Email',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Plz Enter your Email';
                                  } else if (!RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value)) {
                                    return 'invalid Email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              WButton(
                                label: 'Submit',
                                onPressed: postNameAndEmail,
                                gradient: true,
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
