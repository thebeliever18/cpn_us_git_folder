import 'dart:convert';
import 'dart:developer';
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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final NavigationHelper navigationHelper = sl<NavigationHelper>();

  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showNewPassword = false;
  bool isToLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password', style: TextStyle(
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

                Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _oldPassword,
                        obscureText: !showPassword,
                        style: const TextStyle(color: Colors.black54, fontSize: 16.0),
                        // decoration: passwordTextFormField('Password', controller.showPassword()),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: showPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            onPressed: () {
                              if (showPassword == true) {
                                setState((){showPassword = false;});
                              } else {
                                setState((){showPassword = true;});
                              }
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Old Password",
                          labelStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.normal
                          ),
                          // Set border for enabled state (default)
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _newPassword,
                        obscureText: !showNewPassword,
                        style: const TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: showNewPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                              onPressed: () {
                                if (showNewPassword == true) {
                                  setState((){showNewPassword = false;});
                                } else {
                                  setState((){showNewPassword = true;});
                                }
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "New Password",
                            labelStyle: const TextStyle(
                                fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.normal
                            ),
                            // Set border for enabled state (default)
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // Set border for focused state
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: Colors.green),
                              borderRadius: BorderRadius.circular(5),
                            ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _confirmPassword,
                        obscureText: !showNewPassword,
                        style: const TextStyle(color: Colors.black54, fontSize: 16.0),
                        // decoration: passwordTextFormField('Password', controller.showPassword()),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: showNewPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            onPressed: () {
                              if (showNewPassword == true) {
                                setState((){showNewPassword = false;});
                              } else {
                                setState((){showNewPassword = true;});
                              }
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Confirm Password",
                          labelStyle: const TextStyle(
                              fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.normal
                          ),
                          // Set border for enabled state (default)
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
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

                            if (_oldPassword.text.isNotEmpty && _newPassword.text.isNotEmpty && _confirmPassword.text.isNotEmpty) {
                              if (_newPassword.text.toString() == _confirmPassword.text.toString()) {
                                changePasswordAction(_oldPassword.text.toString(), _newPassword.text.toString());
                              } else {
                                errorLongToast("New password and confirm password must be same");
                              }
                            } else {
                              errorToast("All fields are mandatory");
                            }
                          },
                          child: isToLoadMore ? const SizedBox(height: 24.0, width: 24.0, child: CircularProgressIndicator(color: Colors.white),
                          ) : const Text('Change Password', style: TextStyle(
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

  void changePasswordAction(String oldPassword, String newPassword) async {
    setState(() {isToLoadMore = true;});
    var dio = Dio();
    var formData = FormData.fromMap({
      'oldpassword': oldPassword,
      'newpassword': newPassword,
      'userid': AppJSON.logInfo[0]['userdata']['userid'].toString()
    });

    print({
      'oldpassword': oldPassword,
      'newpassword': newPassword,
      'userid': AppJSON.logInfo[0]['userdata']['userid'].toString()
    }.toString());

    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/changepassword',
        data: formData,
      options: Options(
      headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${AppJSON.logInfo[0]['token'].toString()}"
      },
    ),
    ).catchError((onError) {
      log(onError.response.toString());
      var errorJson = jsonDecode(onError.response.toString());
      errorLongToast(errorJson['message'].toString());
      setState(() {isToLoadMore = false;});
    });

    if (response.statusCode == 200) {

      print(response.data.toString());

      var responseData = await response.data;

      var myJSON = json.decode(responseData.toString());

      if (myJSON['type'].toString() == 'error') {
        errorLongToast(myJSON['message'].toString());
        setState(() {isToLoadMore = false;});
      } else {
        successToast(myJSON['message'].toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();

        setState(() {isToLoadMore = false;});
        navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
      }
    } else {
      errorToast("Something went wrong");
      setState(() {isToLoadMore = false;});
    }
  }
}

