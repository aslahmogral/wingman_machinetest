import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/custom_theme.dart';
import 'package:wingman_machinetest/screens/send_otp_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName = 'User'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token = '';

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString(Constants.token_key).toString();
    });

    print(token);
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: WTheme.primaryGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text('Welcome ${widget.userName}'),
            actions: [
              IconButton(
                  onPressed: () {
                    onExit(context);
                  },
                  icon: Icon(Icons.exit_to_app))
            ],
          ),
          body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: CustomTheme(
                  child1: AnimationContainer(lottie: 'animation/avatar.json'),
                  child2: Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "your token is $token",
                            style: WTheme.primaryHeaderStyle,
                          ),
                          Text(Contents.para1),
                          Text(Contents.para2),
                          Text(Contents.para3),
                          Text(Contents.para4),
                          Text(Contents.para5),
                        ],
                      ),
                    ),
                  )))),
    );
  }

  Future<dynamic> onExit(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(Dimens.borderRadius_small)),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.borderRadius_small),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () async {
                            final SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove(Constants.user_key);
                            pref.remove(Constants.token_key);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SendOtpScreen()));
                          },
                          child: Text(Constants.logout)),
                      Divider(),
                      SizedBox(
                        height: Dimens.Padding_small,
                      ),
                      InkWell(
                          onTap: () => exit(0), child: Text(Constants.exit)),
                      Divider(),
                      SizedBox(
                        height: Dimens.Padding_small,
                      ),
                      WButton(
                        label: Constants.cancel,
                        gradient: true,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
