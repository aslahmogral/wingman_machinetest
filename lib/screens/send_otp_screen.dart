import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wingman_machinetest/components/animation_container.dart';
import 'package:wingman_machinetest/components/bottom_sheet.dart';
import 'package:wingman_machinetest/components/button.dart';
import 'package:wingman_machinetest/components/custom_theme.dart';
import 'package:wingman_machinetest/components/loader.dart';
import 'package:wingman_machinetest/components/textformfield.dart';
import 'package:wingman_machinetest/provider/otp_provider.dart';
import 'package:wingman_machinetest/screens/enter_otp_screen.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/constants.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({super.key});

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  final mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String mobileNumber = '';
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

  sendOtp() async {
    bool isValidated = _formKey.currentState!.validate();
    if (isValidated) {
      isLoadingNotifier.value = true;
      final response = await Provider.of<OtpProvider>(context, listen: false)
          .sendOtp(mobileNumber: mobileController.text);
      print(response);
      if (!response.success!) {
        print('not success');
        isLoadingNotifier.value = false;
      } else {
        String requestId =
            Provider.of<OtpProvider>(context, listen: false).requestId;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnterOtpScreen(
                      returnMobileNumber: (value) {
                        mobileNumber = value;
                      },
                      requestId: requestId,
                      mobileNumber: mobileController.text,
                    )));
        isLoadingNotifier.value = false;
      }
    }
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
                        centerTitle: true,
                        title: Text('Welcome'),
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                      ),
                      body: GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus!.unfocus(),
                        child: CustomTheme(
                          child1: AnimationContainer(
                              lottie: 'animation/mobilenumber.json'),
                          child2: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    Constants.enter_number,
                                    style: WTheme.primaryHeaderStyle,
                                  ),
                                  SizedBox(
                                    height: Dimens.padding_xxl,
                                  ),
                                  WTextFormField(
                                    label: Constants.india_code,
                                    textEditingController: mobileController,
                                    textInputType: TextInputType.phone,
                                    validator: (value) {
                                      return regExpMobileNumber(value);
                                    },
                                  ),
                                  SizedBox(
                                    height: Dimens.padding_xxl,
                                  ),
                                  Text(Constants.we_will_send_otp),
                                  SizedBox(
                                    height: Dimens.Padding_xs,
                                  ),
                                  Text(
                                    Constants.carrier_rate,
                                    style:
                                        TextStyle(color: WColors.primaryColor),
                                  ),
                                  SizedBox(
                                    height: Dimens.padding_xxl,
                                  ),
                                  WButton(
                                    gradient: true,
                                    label: Constants.continuee,
                                    onPressed: () => sendOtp(),
                                  ),
                                  SizedBox(height: Dimens.padding,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )

                      // ),
                      ),
                );
        });
  }

  String? regExpMobileNumber(String? value) {
    if (value!.isEmpty) {
      return Constants.mobile_empty_validator;
    } else if (!RegExp(
            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
        .hasMatch(value)) {
      return Constants.invalid_mobilenumber;
    }
    return null;
  }
}
