import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/new_user_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:pinput/pinput.dart';

class EnterOtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String requestId;
  final Function? returnMobileNumber;

  const EnterOtpScreen(
      {super.key,
      required this.requestId,
      required this.mobileNumber,
      this.returnMobileNumber});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  bool isNewUser = false;
  final otpController = TextEditingController();
  // bool profileExist = false;
  bool? isOtpStatus;

  final _formKey = GlobalKey<FormState>();

  verifyOtp() async {
    bool isValidated = _formKey.currentState!.validate();
    if (isValidated) {
      final response = await Provider.of<OtpProvider>(context, listen: false)
          .verfyOtp(requestId: widget.requestId, otp: otpController.text);
      if (!response.success!) {
        print('aslah : verifyotpscreen :error');
        print("[[[[[[[[[[[[[[[[fail]]]]]]]]]]]]]]]]");
      } else {
        print('aslah : verifyotpscreen :success');
        print("[[[[[[[[[[[[[[[[success]]]]]]]]]]]]]]]]");
        bool otpstatus =
            Provider.of<OtpProvider>(context, listen: false).otpStatus;
        print("----otstatus--------------$otpstatus-----------");

        if (otpstatus) {
          bool profileExist =
              Provider.of<OtpProvider>(context, listen: false).profileExist;

          if (profileExist) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            var token = Provider.of<OtpProvider>(context, listen: false).token;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewUserScreen(
                          token: token,
                        )));
          }
        }
      }
    }
  }

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
            title: Text('Enter Verification Code'),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: Container(
              child: Stack(
                children: [
                  InkWell(
                      onTap: () {
                        print(isOtpStatus);
                      },
                      child: AnimationContainer(lottie: 'animation/otp.json')),
                  Positioned(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: WBottomSheet(
                          child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Enter OTP',
                                style: WTheme.primaryHeaderStyle,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text('We have sent otp on your number'),
                              Text('+91-${widget.mobileNumber}'),
                              SizedBox(
                                height: 16,
                              ),
                              Pinput(
                                validator: (code) {
                                  if (code!.isEmpty) {
                                    return 'plz enter code to continue';
                                  } else if (isOtpStatus == true) {
                                    return 'entered otp is wrong';
                                  }
                                  return null;
                                },
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                controller: otpController,
                                length: 6,
                                defaultPinTheme: PinTheme(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: WColors.primaryColor))),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              WButton(
                                gradient: true,
                                label: 'Verify',
                                onPressed: () => verifyOtp(),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              WButton(
                                gradient: false,
                                textColor: WColors.primaryColor,
                                buttonColor: WColors.brightColor,
                                label: 'Retry',
                                onPressed: () {
                                  widget
                                      .returnMobileNumber!(widget.mobileNumber);
                                  Navigator.pop(context);
                                },
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
