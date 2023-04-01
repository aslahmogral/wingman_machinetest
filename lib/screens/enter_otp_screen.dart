import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:wingman_machinetest/screens/homescreen.dart';
import 'package:wingman_machinetest/screens/profile_submit_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:pinput/pinput.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

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
  bool isOtpStatus = false;

  final _formKey = GlobalKey<FormState>();

  saveLogginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.sharedpreference_key, 'user');
  }

  verifyOtp() async {
    bool isValidated = _formKey.currentState!.validate();
    if (isValidated) {
      final response = await Provider.of<OtpProvider>(context, listen: false)
          .verfyOtp(requestId: widget.requestId, otp: otpController.text);
      if (!response.success!) {
      } else {
        bool otpstatus =
            Provider.of<OtpProvider>(context, listen: false).otpStatus;

        if (otpstatus) {
          bool profileExist =
              Provider.of<OtpProvider>(context, listen: false).profileExist;

          if (profileExist) {
            saveLogginInfo();

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            var token = Provider.of<OtpProvider>(context, listen: false).token;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileSubmitScreen(
                          token: token,
                        )));
          }
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      'Something Went Wrong',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('The Otp you have entered'),
                        Text(otpController.text),
                        Text('Might be wrong'),
                        SizedBox(
                          height: Dimens.Padding_small,
                        ),
                        WButton(
                          label: Constants.close,
                          gradient: true,
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ));
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
            title: Text(Constants.enter_verification_code),
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
                                Constants.enter_otp,
                                style: WTheme.primaryHeaderStyle,
                              ),
                              SizedBox(
                                height: Dimens.Padding_large,
                              ),
                              Text(Constants.sent_otp_to_mobile),
                              Text('+91-${widget.mobileNumber}'),
                              SizedBox(
                                height: Dimens.padding,
                              ),
                              Pinput(
                                validator: (code) {
                                  if (code!.isEmpty) {
                                    return Constants.otp_empty_validator;
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
                                height: Dimens.padding_xl,
                              ),
                              WButton(
                                gradient: true,
                                label: Constants.verify,
                                onPressed: () => verifyOtp(),
                              ),
                              SizedBox(
                                height: Dimens.Padding_small,
                              ),
                              WButton(
                                gradient: false,
                                textColor: WColors.primaryColor,
                                buttonColor: WColors.brightColor,
                                label: Constants.retry,
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
