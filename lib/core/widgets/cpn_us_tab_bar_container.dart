import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CpnUsTabBarContainer extends StatelessWidget {
  const CpnUsTabBarContainer({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s30,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p25),
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s20)),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
