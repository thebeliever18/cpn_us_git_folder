import 'dart:convert';
import 'dart:developer';
import 'package:cpn_us/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_json.dart';
import '../../../../core/error/toast_response.dart';
import '../../../../core/helper/navigation_helper/navigation_helper.dart';
import '../../../../dependency_injection.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../register/presentation/pages/register_view.dart';
import '../widget/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final NavigationHelper navigationHelper = sl<NavigationHelper>();

  final _mobile = TextEditingController();
  final _password = TextEditingController();
  bool showPassword = false;
  bool isToLoadMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SIGN IN', style: TextStyle(
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
                        const Text("Welcome User,", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4.0),
                        const Text('We require your credential to verify its you!', style: TextStyle(
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
                        style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                        decoration: customTextFormField("Mobile Number"),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _password,
                        obscureText: !showPassword,
                        style: const TextStyle(color: Colors.black87, fontSize: 16.0),
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
                            labelText: "Password",
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

                      const SizedBox(height: 5.0),

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen())),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('Forget Password?', style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold,
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      Container(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(ColorManager.themeBlueColor),
                          ),
                          onPressed: () {
                            if (_mobile.text.isNotEmpty && _password.text.isNotEmpty) {
                              checkLoginResponse(_mobile.text.toString(), _password.text.toString());
                            } else {
                              errorToast("All fields are mandatory");
                            }
                          },
                          child: isToLoadMore ? const SizedBox(height: 24.0, width: 24.0, child: CircularProgressIndicator(color: Colors.white),
                          ) : const Text('Login', style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0)),
                        ),
                      ),

                      const SizedBox(height: 35.0),

                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView())),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(text: 'Are you new in CPN US? ', style: TextStyle(fontSize: 15.0)),
                                TextSpan(
                                  text: 'Click on register',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: ColorManager.themeRedColor),
                                ),
                                TextSpan(text: ' to create your new account.', style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          ),
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

  void checkLoginResponse(String mobile, String password) async {
    setState(() {isToLoadMore = true;});
    var dio = Dio();
    var formData = FormData.fromMap({
      'mobilenumber': mobile,
      'password': password
    });
    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/login',
        data: formData
    ).catchError((onError) {
      var errorJson = jsonDecode(onError.response.toString());
      errorLongToast(errorJson['message'].toString());
      setState(() {isToLoadMore = false;});
    });

    if (response.statusCode == 200) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> map = response.data;
      prefs.setString('key', json.encode(map));

      AppJSON.logInfo.add(response.data);

      successToast("Login success");
      setState(() {isToLoadMore = false;});
      navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
    } else {
      errorToast("Something went wrong");
      setState(() {isToLoadMore = false;});
    }
  }
}

