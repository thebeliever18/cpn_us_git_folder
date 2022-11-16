import 'dart:async';


import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/resources/assets_manager.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final NavigationHelper navigationHelper = sl<NavigationHelper>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: 1), _goNext);
  }

  _goNext() {
    navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManager.primary,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),),
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}
