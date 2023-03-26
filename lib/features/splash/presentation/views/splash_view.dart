import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/resources/assets_manager.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_json.dart';
import '../../../../core/data/temp.dart';
import '../../../../core/error/toast_response.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final NavigationHelper navigationHelper = sl<NavigationHelper>();
  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 50), _goNext);
  }

  _goNext() {
    navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();

    _isMasterData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.primary,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),),
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  // login
  Future<void> _isMasterData() async {

    // save the user login values in the list
    if ((await getUserLog()) != null) {
      AppJSON.logInfo.add(await getUserLog());
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var dio = Dio();
        final response = await dio.get("https://cpnapp.itsolutionsnepal.com/api/mastersetup",
          options: Options(
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ).catchError((onError) {
          errorToast("Something went wrong. Try again later");
        });

        final responseData = response.data;
        if (response.statusCode == 200) {
          TempClass.isMasterList.add(responseData);
          _startDelay();
        } else {
          errorToast(responseData['message'].toString());
        }
      }
    } on SocketException catch (_) {
      errorToast('No Internet connection found');
    }
  }

  // get user login data
  static Future<Map<String, dynamic>?> getUserLog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>? getMap = await json.decode(prefs.getString('key').toString());
    return getMap;
  }
}
