import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cpn_us/core/error/toast_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/app_json.dart';
import '../../../../core/helper/navigation_helper/navigation_helper.dart';
import '../../../../dependency_injection.dart';
import '../../../../resources/routes_manager.dart';

class ScannerScreen extends StatefulWidget {

  String? whatToScan;
  ScannerScreen({this.whatToScan});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  final NavigationHelper navigationHelper = sl<NavigationHelper>();

  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;
  bool apiHold = false;

  bool apiFoodStatus = false;
  String responseMessage = '';

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
    if (apiHold == false) {
      getRollBack();
      log('scan document: ' + code.toString());
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Scan: ${widget.whatToScan.toString()} ');
    return Scaffold(
      backgroundColor: Colors.white,
      body: _camState
          ? Center(
            child: SizedBox(
              height: 1000,
              width: 500,
              child: QRBarScannerCamera(
                onError: (context, error) => Text(
                  error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
                qrCodeCallback: (code) {
                  _qrCallback(code);
                },
              ),
            ),
          )
          : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (responseMessage == '')
                  Image.asset("assets/images/qr_animation.gif")
                else
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Image.asset("assets/images/qrpic.png", height: 100.0),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(responseMessage == '' ? 'Scanning took long time. Please try again later' :
                  responseMessage, style:
                  TextStyle(fontSize: 16.0, color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),

                if (responseMessage == '')
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width:  200,
                    height: 50.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(255, 44, 85, 2)),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel Request', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))),
                  ),

                if (responseMessage != '')
                  Container(
                    margin: EdgeInsets.only(top: 70.0),
                    width:  200,
                    height: 50.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(255, 44, 85, 2)),
                        onPressed: () => navigationHelper.pushReplacementNamed(Routes.onBoardingRoute),
                        child: Text('Return Home', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold))),
                  ),
              ],
            ),
           // child: Text(_qrInfo!),
      ),
    );
  }

  // checkin
  Future<void> scanResultMethod() async {

    setState(() {apiHold = true;});

    var myJSON = {
      "memberid":AppJSON.logInfo[0]['userdata']['userid'].toString(),
      "qrid":_qrInfo
    };

    print(myJSON.toString());

    var formData = FormData.fromMap(myJSON);

    var dio = Dio();
    String checkQRURL = "https://cpnapp.itsolutionsnepal.com/api/attendance";
    final response = await dio.post(
      checkQRURL,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${AppJSON.logInfo[0]['token'].toString()}"
        },
      ),
      data: formData,
    ).catchError((error, stackTrace) {
      log(error.toString());
    });

    var responseValue = await json.decode(response.data.toString());

    print(responseValue.toString());

    if (response.statusCode == 200) {
      setState(() {
        responseMessage = responseValue['message'];
      });
      successToast(responseMessage);
      // navigationHelper.pushReplacementNamed(Routes.onBoardingRoute);
    }
  }

  // check network connection
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  void getRollBack() async {
    bool checkInternetStatus = await checkInternetConnection();

    final status = Permission.contacts.request();

    if(await status.isGranted){
      // permission has granted now save the contact here
    }

    if (checkInternetStatus == true) {
      scanResultMethod();
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please check your internet connection and try again'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}