import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/send_otp_screen.dart';
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
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>user !=null ?HomeScreen(userName: user,) : SendOtpScreen())));});

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset( 'animation/splash.json',fit: BoxFit.fitHeight,height: MediaQuery.of(context).size.height);
    
  }
}
