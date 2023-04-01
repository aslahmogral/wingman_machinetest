import 'package:flutter/material.dart';
import 'package:wingman_machinetest/utils/colors.dart';
import 'package:wingman_machinetest/utils/dimens.dart';

class WBottomSheet extends StatelessWidget {
  final Widget child;
  const WBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: WColors.primaryColor,
          color: WColors.dimWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.borderRadius_small), topRight: Radius.circular(Dimens.borderRadius_small))),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(Dimens.padding_xl),
        child: child,
      ),
    );
  }
}
