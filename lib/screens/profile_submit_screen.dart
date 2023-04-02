import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/custom_theme.dart';
import 'package:wingman_machinetest/components/loader.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class ProfileSubmitScreen extends StatefulWidget {
  const ProfileSubmitScreen({
    super.key,
  });

  @override
  State<ProfileSubmitScreen> createState() => _ProfileSubmitScreenState();
}

class _ProfileSubmitScreenState extends State<ProfileSubmitScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  saveLogginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.user_key, nameController.text);
  }

  postNameAndEmail(String name, email) async {
    bool isValidated = _formKey.currentState!.validate();

    if (isValidated) {
      isLoadingNotifier.value = true;

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString(Constants.token_key).toString();
        final response = await Provider.of<OtpProvider>(context, listen: false)
            .profileSubmit(name: name, email: email, token: token);

        if (!response.success!) {
          isLoadingNotifier.value = false;
        } else {
          saveLogginInfo();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        userName: nameController.text,
                      )));
          isLoadingNotifier.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
    isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLoadingNotifier,
        builder: (contex, bool isloading, child) {
          return isloading
              ? LoaderBird()
              : Container(
                  decoration: BoxDecoration(gradient: WTheme.primaryGradient),
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        title: Text(Constants.enter_name_email),
                      ),
                      body: GestureDetector(
                          onTap: () =>
                              FocusManager.instance.primaryFocus!.unfocus(),
                          child: CustomTheme(
                              child1: AnimationContainer(
                                  lottie: 'animation/newuser.json'),
                              child2: Form(
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
                                        ),
                                        gradient: true,
                                      )
                                    ],
                                  ),
                                ),
                              )))),
                );
        });
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
