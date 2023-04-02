import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class WBottomSheet extends StatelessWidget {
  final Widget child;
  const WBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var decoration=
    BoxDecoration(
      boxShadow: [
        BoxShadow(
          spreadRadius: 1.0,
          blurRadius: 8.0,
          offset: Offset(0, -3.0),
          color: WColors.brightColor.withOpacity(0.6),
        )
      ],
      color: WColors.dimWhiteColor,
      borderRadius: BorderRadius.only(
        
          topLeft: Radius.circular(Dimens.padding_xxl),
          topRight: Radius.circular(Dimens.padding_xxl)),
    );
    return Container(
      decoration: decoration,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding_xl),
        child: child,
      ),
    );
  }
}
