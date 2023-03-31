import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/apptheme.dart';
import 'package:wingman_machinetest/utils/colors.dart';

class WButton extends StatefulWidget {
  final void Function()? onPressed;
  final String label;
  final Color? buttonColor;
  final Color? textColor;
  final bool gradient;
  const WButton(
      {super.key, this.onPressed, required this.label, this.buttonColor, this.textColor, required this.gradient});

  @override
  State<WButton> createState() => W_ButtonState();
}

class W_ButtonState extends State<WButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            gradient:widget.gradient ? WTheme.primaryGradient : null,
              color:widget.gradient? null : widget.buttonColor ?? WColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(color:widget.textColor?? WColors.dimWhiteColor),
            ),
          ),
        ));
  }
}
