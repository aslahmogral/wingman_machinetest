import 'package:flutter/material.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  const HomeScreen({super.key, this.userName = 'User'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: WTheme.primaryGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text('Welcome ${widget.userName}'),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  AnimationContainer(lottie: 'animation/avatar.json'),
                  Positioned(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: WBottomSheet(
                          child: Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Contents.para1),
                              Text(Contents.para2),
                              Text(Contents.para3),
                              Text(Contents.para4),
                              Text(Contents.para5),
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
