import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';

class WButton extends StatefulWidget {
  
  final void Function()? onPressed;
  final String label;
  const WButton({super.key, this.onPressed, required this.label});

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
              color: WColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(color: WColors.dimWhiteColor),
            ),
          ),
        ));
  }
}
