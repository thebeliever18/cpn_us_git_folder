import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_json.dart';
import '../../../../core/error/toast_response.dart';
import '../../../../resources/color_manager.dart';
import '../widget/more_widget.dart';

class MoreView extends StatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {

  bool isToLoadMore = true;

  bool cardVisible = true;
  double? width, height;

  List myCardList = [];
  String qrGenerate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findProfile();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.themeBlueColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: ColorManager.themeBlueColor,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: ColorManager.themeBlueColor,
        title: Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      ),
      body: isToLoadMore ?
      Center(child: CircularProgressIndicator()) :
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 249, 249, 1.0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    const SizedBox(height: 50.0),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(myCardList[0]['response']['fullname'].toString(),
                            style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold)),

                        if (myCardList[0]['response']['approvedstatus'].toString().toLowerCase() != 'pending')
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.verified, color: Colors.blue),
                          )
                        else
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.pending, color: Colors.red),
                          ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text("+977 "+myCardList[0]['response']['mobilenumber'],
                          style: TextStyle(color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold)),
                    ),

                    const SizedBox(height: 10.0),
                    if (myCardList[0]['response']['approvedstatus'].toString().toLowerCase() == 'pending')
                      Container(
                        margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          // color: ColorManager.themeRedColor,
                          border: Border.all(color: Colors.grey[300]!, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Note: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.red),
                              ),
                              TextSpan(text: ' Membership request pending',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.red),),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 10.0),
                    Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  cardVisible = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]!, width: cardVisible ? 0.0 : 1.0),
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: cardVisible ? ColorManager.themeRedColor : Colors.grey[200]!
                                ),
                                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 10.0, left: 10.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.credit_card, color: cardVisible ? Colors.grey[200] : Colors.black54, size: 20.0),
                                      const SizedBox(width: 10.0),
                                      Expanded(child: Text('Card', style: TextStyle(
                                          fontSize: 15.0, fontWeight: FontWeight.bold, color: cardVisible ? Colors.grey[300] : Colors.black54))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  cardVisible = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]!, width: !cardVisible ? 0.0 : 1.0),
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: !cardVisible ? ColorManager.themeRedColor : Colors.grey[200]!
                                ),
                                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 10.0, left: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.receipt_outlined, color: !cardVisible ? Colors.grey[200] : Colors.black54, size: 20.0),
                                    const SizedBox(width: 10.0),
                                    Expanded(child: Text('Details', style: TextStyle(
                                        fontSize: 15.0, fontWeight: FontWeight.bold, color: !cardVisible ? Colors.grey[300] : Colors.black54))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showDataAlert();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400]!, width: 1.0),
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.grey[200]!
                                ),
                                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0, right: 10.0, left: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.share, color: Colors.black54, size: 20.0),
                                    const SizedBox(width: 10.0),
                                    Expanded(child: Text('Share', style: TextStyle(
                                        fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black54))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),


                    Visibility(
                      visible: cardVisible,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
                        height: 280.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/card.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: myCardList[0]['response']['approvedstatus'].toString().toLowerCase() != 'pending' ? Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const SizedBox(height: 80.0),
                                Container(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(myCardList[0]['response']['classdescription'].toString(), style: TextStyle(
                                            fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold
                                        ),),
                                      ),

                                      const SizedBox(height: 20.0),

                                      Container(
                                        margin: const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'सदस्यता नम्बर: ', style: TextStyle(
                                                      fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: '019200CPN',
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'प्रमाणित गर्नेको हस्ताक्षर: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: "",
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'नाम थर: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['fullname'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'स्थायी ठेगाना: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['districtname'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'नाम थर: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['approvedbyname'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'जन्म मिति: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['dob'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'कमिटी र पद: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['classname'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'प्राप्त मिति: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['approveddate'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(text: 'प्रमाणित गरेको मिति: ', style: TextStyle(
                                                        fontSize: 13.0
                                                    )),
                                                    TextSpan(
                                                      text: myCardList[0]['response']['approveddate'].toString(),
                                                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 38.0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: width!/11 + 2.0),
                                // child: Image.asset("assets/images/user1.png", height: 70.0),
                                child: CachedNetworkImage(
                                  height: 65.0, width: 55.0,
                                  fit: BoxFit.cover,
                                  imageUrl: myCardList[0]['response']['profileimage'].toString(),
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ],
                        ) : ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: !cardVisible,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0, left: 12.0, right: 12.0),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[

                            Container(
                              padding: const EdgeInsets.all(4.0),
                              margin: const EdgeInsets.only(bottom: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 1.0),
                                borderRadius: BorderRadius.circular(3.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  // header
                                  Row(
                                    children: <Widget>[

                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              const SizedBox(height: 10.0),
                                              Text(myCardList[0]['response']['fullname'].toString(), style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 15.0)),
                                              const SizedBox(height: 7.0),

                                              onlineTileContentText('जन्म मिति', myCardList[0]['response']['dob'].toString()),
                                              const SizedBox(height: 3.0),
                                              onlineTileContentText('बुबाको नाम', myCardList[0]['response']['fatherName'].toString()),
                                              const SizedBox(height: 3.0),
                                              onlineTileContentText('आमाको नाम', myCardList[0]['response']['motherName'].toString()),
                                              const SizedBox(height: 3.0),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: onlineTileContentText('पहिचान प्रकार', myCardList[0]['response']['identitype'].toString()),
                                                  ),
                                                  // const SizedBox(width: 10.0),
                                                  // Expanded(
                                                  //   child: onlineTileContentText('पहिचान नं', myCardList[0]['response']['identitynumber'].toString()),
                                                  // )
                                                ],
                                              ),
                                              const SizedBox(height: 3.0),
                                              onlineTileContentText('मोबाईल नं', myCardList[0]['response']['mobilenumber'].toString()),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      // see more data
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              const Padding(
                                                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                                                child: Text('ठेगाना', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                              ),

                                              offlineItemText(
                                                  'Pradesh', myCardList[0]['response']['provisionname'].toString(),
                                                  'District', myCardList[0]['response']['districtname'].toString()
                                              ),

                                              offlineItemText(
                                                  'Municipality', myCardList[0]['response']['municipalityname'].toString(),
                                                  '', ''
                                              ),

                                              offlineItemText(
                                                  'Tole', myCardList[0]['response']['fulladdress'].toString(),
                                                  'Ward No', myCardList[0]['response']['wardnumber'].toString()
                                              ),

                                              Container(
                                                margin: const EdgeInsets.only(bottom: 10.0),
                                                child: const DottedLine(
                                                  dashColor: Colors.grey,
                                                ),
                                              ),

                                              const Padding(
                                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                                child: Text('अन्य विवरण', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                              ),

                                              offlineItemText(
                                                  'Profession', myCardList[0]['response']['professionname'].toString(),
                                                  'Education', myCardList[0]['response']['educationname'].toString()
                                              ),

                                              offlineItemText(
                                                  "Class", myCardList[0]['response']['classname'].toString(),
                                                  'Class Description', myCardList[0]['response']['classdescription'].toString()
                                              ),

                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      // see more data
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                            
                                              Container(
                                                margin: const EdgeInsets.only(bottom: 10.0),
                                                child: const DottedLine(
                                                  dashColor: Colors.grey,
                                                ),
                                              ),

                                              const Padding(
                                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                                child: Text('पहिचान कागजात', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                              ),

                                              if (myCardList[0]['response']['identitype'].toString() == 'नागरिकता')
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: CachedNetworkImage(
                                                          height: 200.0,
                                                          imageUrl: myCardList[0]['response']['citizenshipFront'].toString(),
                                                          placeholder: (context, url) => CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10.0),
                                                      Expanded(
                                                        child: CachedNetworkImage(
                                                          height: 200.0,
                                                          imageUrl: myCardList[0]['response']['citizenshipBack'].toString(),
                                                          placeholder: (context, url) => CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              else if (myCardList[0]['response']['identitype'].toString() == 'राहदानी')
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: CachedNetworkImage(
                                                          height: 200.0,
                                                          imageUrl: myCardList[0]['response']['passport'].toString(),
                                                          placeholder: (context, url) => CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              else if (myCardList[0]['response']['identitype'].toString() == 'प्यान')
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: CachedNetworkImage(
                                                            height: 200.0,
                                                            imageUrl: myCardList[0]['response']['pan'].toString(),
                                                            placeholder: (context, url) => CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                              else if (myCardList[0]['response']['identitype'].toString() == 'जन्म दर्ता')
                                                  Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: CachedNetworkImage(
                                                            height: 200.0,
                                                            imageUrl: myCardList[0]['response']['birthCertificate'].toString(),
                                                            placeholder: (context, url) => CircularProgressIndicator(),
                                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: MediaQuery.of(context).size.width/2 - 45,
              child: Container(
                margin: const EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90.0),
                    border: Border.all(color: Colors.white, width: 5.0)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90.0),
                  // child: Image.asset("assets/images/user.jpg", width: 80.0, height: 80.0, fit: BoxFit.cover),
                  child: CachedNetworkImage(
                    height: 80.0, width: 80.0,
                    fit: BoxFit.cover,
                    imageUrl: myCardList[0]['response']['profileimage'].toString(),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void findProfile() async {
    setState(() {isToLoadMore = true;});
    var dio = Dio();

    var formData = FormData.fromMap({
      'userid': AppJSON.logInfo[0]['userdata']['userid'].toString()
    });
    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/mycard',
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AppJSON.logInfo[0]['token'].toString()}",
        })
    );

    if (response.statusCode == 200) {
      setState(() {
        myCardList.add(json.decode(response.data.toString()));
      });
      setState(() {
        isToLoadMore = false;
        qrGenerate = "BEGIN:VCARD\nVERSION:3.0\nN:${myCardList[0]['response']['fullname']}\nADR:${myCardList[0]['response']['fulladdress']}\nTEL;CELL:${myCardList[0]['response']['mobilenumber']}\nEMAIL;WORK;INTERNET:${myCardList[0]['response']['email']}\nEND:VCARD";
      });
    } else {
      errorToast("Something went wrong");
      setState(() {isToLoadMore = false;});
    }
  }

  showDataAlert() {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(15.0),
          contentPadding: const EdgeInsets.all(14.0),
          title: Align(
            alignment: Alignment.center,
            child: Text('Share Contact', style: TextStyle(fontSize: 18.0, color: Colors.black87)),
          ),
          content: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListBody(
              children: <Widget>[

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    child: QrImage(
                      data: qrGenerate.toString(),
                      version: QrVersions.auto,
                      size: 300,
                      gapless: false,
                    ),
                  ),
                ),

                const SizedBox(height: 5.0),

                Align(
                  alignment: Alignment.center,
                  child: Text(myCardList[0]['response']['fullname'].toString(),
                      style: TextStyle(fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.center,
                  child: Text(myCardList[0]['response']['mobilenumber'].toString(),
                      style: TextStyle(fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.normal)),
                ),
                const SizedBox(height: 5.0),
                Align(
                  alignment: Alignment.center,
                  child: Text(myCardList[0]['response']['email'].toString(),
                      style: TextStyle(fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.normal)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
