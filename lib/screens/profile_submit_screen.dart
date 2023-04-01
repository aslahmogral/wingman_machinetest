import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class ProfileSubmitScreen extends StatefulWidget {
  final String token;
  const ProfileSubmitScreen({super.key, required this.token});

  @override
  State<ProfileSubmitScreen> createState() => _ProfileSubmitScreenState();
}

class _ProfileSubmitScreenState extends State<ProfileSubmitScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  saveLogginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.sharedpreference_key, nameController.text);
  }

  postNameAndEmail(String name, email, token) async {
    bool isValidated = _formKey.currentState!.validate();
    final tokenr = await Provider.of<OtpProvider>(context, listen: false).token;

    if (isValidated) {
      try {
        final response = await Provider.of<OtpProvider>(context, listen: false)
            .profileSubmit(name: name, email: email, token: tokenr);

        if (!response.success!) {
        } else {
          saveLogginInfo();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        userName: nameController.text,
                        
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
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(Constants.enter_name_email),
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
                                Constants.welcome_msg,
                                style: WTheme.primaryHeaderStyle2,
                              ),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              Text(Constants.enter_details),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              WTextFormField(
                                validator: (value) {
                                  return nameValidator(value);
                                },
                                textEditingController: nameController,
                                label: Constants.enter_name,
                              ),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              WTextFormField(
                                textEditingController: emailController,
                                label: Constants.enter_email,
                                validator: (value) {
                                  return emailValidator(value);
                                },
                              ),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              WButton(
                                label: Constants.submit,
                                onPressed: () => postNameAndEmail(
                                    nameController.text,
                                    emailController.text,
                                    widget.token),
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

  String? nameValidator(String? value) {
     if (value!.isEmpty) {
      return Constants.enter_name;
    }
    return null;
  }

  String? emailValidator(String? value) {
     if (value!.isEmpty) {
      return 'Plz Enter your Email';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'invalid Email address';
    }
    return null;
  }
}
