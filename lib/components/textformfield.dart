import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class WTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  const WTextFormField(
      {super.key,
      this.textEditingController,
      this.label,
      this.hintText,
      this.textInputType, this.validator});

  @override
  State<WTextFormField> createState() => _WTextFormFieldState();
}

class _WTextFormFieldState extends State<WTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.textEditingController,
      validator: widget.validator,
      decoration: InputDecoration(
        
          fillColor: WColors.brightColor,
          filled: true,
          label: Text(
            widget.label.toString(),
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.borderRadius_small),
              borderSide: BorderSide(color: WColors.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.borderRadius_small),
              borderSide: BorderSide(color: WColors.primaryColor))),
    );
  }
}
