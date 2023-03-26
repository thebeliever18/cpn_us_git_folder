import 'dart:convert';
import 'dart:developer';
import 'package:cpn_us/features/login/presentation/pages/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_json.dart';
import '../../../../core/error/toast_response.dart';
import '../../../../core/helper/navigation_helper/navigation_helper.dart';
import '../../../../dependency_injection.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../donation/widget/register_widget.dart';
import '../../../register/presentation/pages/register_view.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final NavigationHelper navigationHelper = sl<NavigationHelper>();

  final _mobile = TextEditingController();
  bool showPassword = false;
  bool showNewPassword = false;
  bool isToLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forget Password', style: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black87
          ),),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black87),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 25.0),
                        Image.asset("assets/images/splash_logo.png", width: 120.0),
                        const SizedBox(height: 20.0),
                        const Text("Forget Password", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
                        const Text('We will send you a new password on your mobile', style: TextStyle(
                          fontSize: 14.0, color: Colors.black54
                        )),
                      ],
                    ))
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _mobile,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: customTextFormField('Mobile number'),
                      ),

                      const SizedBox(height: 40.0),

                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(ColorManager.themeBlueColor),
                          ),
                          onPressed: () {
                            
                            if (_mobile.text.isNotEmpty) {
                              checkForgetPassword(_mobile.text.toString());
                            } else {
                              errorToast("All fields are mandatory");
                            }
                          },
                          child: isToLoadMore ? const SizedBox(height: 24.0, width: 24.0, child: CircularProgressIndicator(color: Colors.white),
                          ) : const Text('Resend Password', style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  void checkForgetPassword(String forgetPassword) async {
    setState(() {isToLoadMore = true;});
    var dio = Dio();
    var formData = FormData.fromMap({
      'mobilenumber': forgetPassword
    });
    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/forget',
        data: formData
    ).catchError((onError) {
      var errorJson = jsonDecode(onError.response.toString());
      errorLongToast(errorJson['message'].toString());
      setState(() {isToLoadMore = false;});
    });

    if (response.statusCode == 200) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

      successToast("Check your email/mobile for a new password. Thank you.");
      setState(() {isToLoadMore = false;});
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    } else {
      errorToast("Something went wrong");
      setState(() {isToLoadMore = false;});
    }
  }
}

