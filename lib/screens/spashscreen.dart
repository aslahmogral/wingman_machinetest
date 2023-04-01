import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/send_otp_screen.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? user;
  Future checkLoggedin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var _user = prefs.getString(Constants.sharedpreference_key);
    setState(() {
      user = _user;
    });
  }

  @override
  void initState() {
    checkLoggedin().whenComplete(() async {Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>user !=null ?HomeScreen(userName: user,) : SendOtpScreen())));});

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WColors.dimWhiteColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset( 'animation/astro.json',));
    
  }
}
