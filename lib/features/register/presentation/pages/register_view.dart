import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cpn_us/core/constants/app_json.dart';
import 'package:cpn_us/core/error/toast_response.dart';
import 'package:cpn_us/features/login/presentation/pages/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../../core/constants/country_data_json.dart';
import '../../../../core/data/temp.dart';
import '../../../../resources/color_manager.dart';
import '../../../donation/widget/register_widget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  // crop image
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  // multiple crop image
  XFile? _pickedFileMultiple;
  CroppedFile? _croppedFileMultiple;

  // citizenship front
  XFile? _pickedFileCitizenshipFront;
  CroppedFile? _croppedFileCitizenshipFront;

  // citizenship back
  XFile? _pickedFileCitizenshipBack;
  CroppedFile? _croppedFileCitizenshipBack;

  // TODO Family member
  // family citizenship front
  XFile? _pickedFileCitizenshipFrontFamily;
  CroppedFile? _croppedFileCitizenshipFrontFamily;

  // family citizenship back
  XFile? _pickedFileCitizenshipBackFamily;
  CroppedFile? _croppedFileCitizenshipBackFamily;

  List<dynamic> myMember = [];

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;
  List<XFile>? _imageSingleList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
    _pickedFileMultiple = value;
  }

  void _setImageSingleListFromFile(XFile? value) {
    _imageSingleList = value == null ? null : <XFile>[value];
    _pickedFile = value;
  }

  // citizenship front
  void _setCitizenshipFront(XFile? value) {
    _pickedFileCitizenshipFront = value;
  }

  // citizenship back
  void _setCitizenshipBack(XFile? value) {
    _pickedFileCitizenshipBack = value;
  }

  // TODO family
  // citizenship front
  void _setCitizenshipFrontFamily(XFile? value) {
    _pickedFileCitizenshipFrontFamily = value;
  }

  // citizenship back
  void _setCitizenshipBackFamily(XFile? value) {
    _pickedFileCitizenshipBackFamily = value;
  }

  dynamic _pickImageError;
  dynamic _pickSingleImageError;
  String? _retrieveDataError;
  String? _retrieveSingleDataError;


  String? selectedProvince;
  String? provinceid;

  String? selectedDistrict;
  String? districtid;

  String? selectedMunicipality;
  String? municipalityid;

  String? selectGender;
  String? selectBloodGroup;
  String? selectedProfession;
  String? professionid;
  String? selectedEducation;
  String? educationid;
  String? selectedCaste;
  String? castid;
  String? selectedMartialStatus;

  String initIndentityType = 'नागरिकता';

  String initPradesh = "Province 1";
  String initDistrict = "Ilam";
  String initMun = "Illam Urban Municipality";

  // list of a district and municipality
  List districtList = [];
  List municipalityList = [];

  // store dynamic values
  List<String>? dropdownDistrict;
  List<String>? dropdownMun;

  // text field
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();
  final _fatherName = TextEditingController();
  final _motherName = TextEditingController();
  final _ward = TextEditingController();
  final _streetAddress = TextEditingController();
  final _identityType = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool showMore = false;
  bool isLoading = false;

  String deviceId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDropdownList();
    getDistrictJSON(initPradesh);
    getMuncipality(initDistrict);

    getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorManager.themeRedColor
    ));
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1.0),
      appBar: AppBar(
        backgroundColor: ColorManager.themeRedColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white)
        ),
        title: Text('Membership Registration (सदस्यता दर्ता)', style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[

              Container(
                margin: const EdgeInsets.only(top: 3.0),
                width: double.infinity,
                decoration: BoxDecoration(
                ),
                child: Text('Profile (सदस्यको फोटो)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                    fontWeight: FontWeight.bold), textAlign:
                TextAlign.left),
              ),

              Container(
                height: 15.0,
                margin: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                width: double.infinity,
                child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                child: DottedBorder(
                  color: Colors.grey[400]!,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    child: Card(
                      elevation: 0,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    _pickedFile = null;
                                  });

                                  // Capture a photo
                                  try {
                                    final XFile? pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera,
                                      maxWidth: 1200.0,
                                      maxHeight: 900.0,
                                      imageQuality: 100,
                                    );
                                    setState(() {
                                      _setImageSingleListFromFile(pickedFile);
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _pickSingleImageError = e;
                                    });
                                  }
                                },
                                child: _image(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                ),
                child: Text('Member Details (सदस्यको विवरणहरू)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                    fontWeight: FontWeight.bold), textAlign:
                TextAlign.left),
              ),

              Container(
                  height: 15.0,
                  margin: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                  width: double.infinity,
                  child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
              ),

              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(color: Colors.black54),
                decoration: customTextFormField("Full Name (पुरा नाम) *"),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _mobile,
                      style: TextStyle(color: Colors.black54),
                      decoration: customTextFormField("Mobile (मोबाइल नम्बर) *"),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        NepaliDateTime? _selectedDateTime = await picker.showMaterialDatePicker(

                          context: context,
                          initialDate: NepaliDateTime.now(),
                          firstDate: NepaliDateTime(2000),
                          lastDate: NepaliDateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                        );
                        setState(() {
                          _dob.text = _selectedDateTime.toString().substring(0, _selectedDateTime.toString().indexOf(' '));
                        });

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: TextFormField(
                        style: TextStyle(color: Colors.black54),
                        controller: _dob,
                        decoration: customTextFormField("D.O.B (जन्म मिति) *"),
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _email,
                style: TextStyle(color: Colors.black54),
                decoration: customTextFormField("Email (इमेल)"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15.0),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                ),
                child: Text('Other Details (अन्य विवरणहरू)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                    fontWeight: FontWeight.bold), textAlign:
                TextAlign.left),
              ),

              Container(
                  height: 15.0,
                  margin: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                  width: double.infinity,
                  child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
              ),

              InputDecorator(
                decoration: dropdownDecorator(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMartialStatus,
                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                    isDense: true,
                    hint: const Text('Martial Status (वैवाहिक स्थिति) *'),
                    items: <String>['Single', 'Married', 'Separate', 'Divorced'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(fontSize: 15.0)),
                      );
                    }).toList(),
                    onChanged: (dataValue) {
                      setState(() {
                        selectedMartialStatus = dataValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _fatherName,
                style: TextStyle(color: Colors.black54),
                decoration: customTextFormField("Father Name (बुबाको नाम)"),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _motherName,
                style: TextStyle(color: Colors.black54),
                decoration: customTextFormField("Mother Name (आमाको नाम)"),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectGender,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Gender (लिङ्ग चयन) *'),
                          items: <String>['Male', 'Female','Other'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            setState(() {
                              selectGender = dataValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectBloodGroup,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Blood Group (रक्त समूह)'),
                          items: <String>["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            setState(() {
                              selectBloodGroup = dataValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedProfession,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Profession (पेशा)'),
                          items: TempClass.isMasterList[0]['profession'].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['professionname'],
                              child: Text(value['professionname'], style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            final index = TempClass.isMasterList[0]['profession'].indexWhere((element) =>
                            element['professionname'] == dataValue);
                            if (index >= 0) {
                              setState((){
                                professionid = TempClass.isMasterList[0]['profession'][index]['professionid'];
                                selectedProfession = dataValue!;
                              });
                              print('Profession id: ${TempClass.isMasterList[0]['profession'][index]['professionid']}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedEducation,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Education (शिक्षा) *'),
                          items: TempClass.isMasterList[0]['education'].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['educationname'],
                              child: Text(value['educationname'], style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            final index = TempClass.isMasterList[0]['education'].indexWhere((element) =>
                            element['educationname'] == dataValue);
                            if (index >= 0) {
                              setState((){
                                educationid = TempClass.isMasterList[0]['education'][index]['educationid'];
                                selectedEducation = dataValue!;
                              });
                              print('Education id: ${TempClass.isMasterList[0]['education'][index]['educationid']}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCaste,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Caste (जात)'),
                          items: TempClass.isMasterList[0]['cast'].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['castname'],
                              child: Text(value['castname'], style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            final index = TempClass.isMasterList[0]['cast'].indexWhere((element) =>
                            element['castname'] == dataValue);
                            if (index >= 0) {
                              setState((){
                                castid = TempClass.isMasterList[0]['cast'][index]['castid'];
                                selectedCaste = dataValue!;
                              });
                              print('Caste id: ${TempClass.isMasterList[0]['cast'][index]['castid']}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),

              Visibility(
                visible: !showMore,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                      child: Text(
                          "Continue".toUpperCase(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(ColorManager.themeBlueColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: ColorManager.themeBlueColor)
                              )
                          )
                      ),
                      onPressed: () {
                        if (_pickedFile != null) {
                          if (_name.text.isNotEmpty && _mobile.text.isNotEmpty &&
                              _dob.text.isNotEmpty) {
                            setState(() {
                              showMore = true;
                            });
                          } else {
                            errorLongToast("* fields are mandatory (* क्षेत्रहरू अनिवार्य छन्)");
                          }
                        } else {
                          errorLongToast("Upload your profile picture (आफ्नो प्रोफाइल तस्वीर अपलोड गर्नुहोस्)");
                        }
                      }
                  ),
                ),
              ),

              Visibility(
                visible: showMore,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                      ),
                      child: Text('Address Details (ठेगाना विवरण)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                          fontWeight: FontWeight.bold), textAlign:
                      TextAlign.left),
                    ),

                    Container(
                        height: 15.0,
                        margin: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                        width: double.infinity,
                        child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InputDecorator(
                            decoration: dropdownDecorator(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedProvince,
                                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                                isDense: true,
                                hint: const Text('Province (प्रदेश)'),
                                items: TempClass.isMasterList[0]['provision'].map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['provisionname'],
                                    child: Text(value['provisionname'], style: const TextStyle(fontSize: 15.0)),
                                  );
                                }).toList(),
                                onChanged: (dataValue) {
                                  final index = TempClass.isMasterList[0]['provision'].indexWhere((element) =>
                                  element['provisionname'] == dataValue);
                                  if (index >= 0) {
                                    setState((){
                                      provinceid = TempClass.isMasterList[0]['provision'][index]['provisionid'];
                                      selectedProvince = dataValue!;
                                      initPradesh = selectedProvince.toString();
                                      getAllDistrict();
                                    });
                                    print('Province id: ${TempClass.isMasterList[0]['provision'][index]['provisionid']}');
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InputDecorator(
                            decoration: dropdownDecorator(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedDistrict,
                                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                                isDense: true,
                                hint: const Text('District (जिल्ला)'),
                                items: districtList.map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['districtname'],
                                    child: Text(value['districtname'], style: const TextStyle(fontSize: 15.0)),
                                  );
                                }).toList(),
                                onChanged: (dataValue) {
                                  final index = districtList.indexWhere((element) =>
                                  element['districtname'] == dataValue);
                                  if (index >= 0) {
                                    setState((){
                                      districtid = districtList[index]['districtid'];
                                      selectedDistrict = dataValue!;
                                      initDistrict = selectedDistrict.toString();
                                      getAllMunicipality();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    InputDecorator(
                      decoration: dropdownDecorator(),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedMunicipality,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                          isDense: true,
                          hint: const Text('Municipality (नगरपालिका)'),
                          items: municipalityList.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['municipalityname'],
                              child: Text(value['municipalityname'], style: const TextStyle(fontSize: 15.0)),
                            );
                          }).toList(),
                          onChanged: (dataValue) {
                            final index = municipalityList.indexWhere((element) =>
                            element['municipalityname'] == dataValue);
                            if (index >= 0) {
                              setState((){
                                municipalityid = municipalityList[index]['municipalityid'];
                                selectedMunicipality = dataValue!;
                                initMun = selectedMunicipality.toString();
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    // InputDecorator(
                    //   decoration: dropdownDecorator(),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<String>(
                    //       value: initMun,
                    //       style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                    //       isDense: true,
                    //       hint: const Text('Select Municipality (नगरपालिका चयन गर्नुहोस्)'),
                    //       items: dropdownMun!.map((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value, style: const TextStyle(fontSize: 14.0)),
                    //         );
                    //       }).toList(),
                    //       onChanged: (dataValue) {
                    //         setState(() {
                    //           initMun = dataValue!;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/4,
                          child: TextFormField(
                            controller: _ward,
                            style: TextStyle(color: Colors.black54),
                            decoration: customTextFormField("Ward No. (वार्ड) *"),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: _streetAddress,
                            style: TextStyle(color: Colors.black54),
                            decoration: customTextFormField("Street Address (सडक ठेगाना) *"),
                            keyboardType: TextInputType.text,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15.0),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                      ),
                      child: Text('Identity Document (पहिचान कागजात)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                          fontWeight: FontWeight.bold), textAlign:
                      TextAlign.left),
                    ),

                    Container(
                        height: 15.0,
                        margin: const EdgeInsets.only(top: 3.0, bottom: 10.0),
                        width: double.infinity,
                        child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
                    ),

                    Container(
                      color: Colors.grey[200],
                      child: InputDecorator(
                        decoration: dropdownDecorator(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: initIndentityType,
                            style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                            isDense: true,
                            hint: const Text('Identity Type (पहिचान प्रकार)'),
                            items: <String>['नागरिकता', 'राहदानी', 'प्यान', 'जन्म दर्ता'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 15.0)),
                              );
                            }).toList(),
                            onChanged: (dataValue) {
                              setState(() {
                                initIndentityType = dataValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    if (initIndentityType == 'नागरिकता')
                      Column(
                        children: <Widget>[
                          // TODO [Citizenship Front]
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: DottedBorder(
                              color: Colors.grey[400]!,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                child: Card(
                                  elevation: 0,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  _pickedFileCitizenshipFrontFamily = null;
                                                  _croppedFileCitizenshipFrontFamily = null;
                                                });

                                                // Capture a photo
                                                try {
                                                  final XFile? pickedFile = await _picker.pickImage(
                                                    source: ImageSource.camera,
                                                    maxWidth: 1200.0,
                                                    maxHeight: 900.0,
                                                    imageQuality: 100,
                                                  );
                                                  setState(() {
                                                    _setCitizenshipFrontFamily(pickedFile);
                                                  });
                                                } catch (e) {
                                                  setState(() {
                                                    _pickSingleImageError = e;
                                                  });
                                                }
                                              },
                                              child: _citizenshipFrontFamily()
                                          ),
                                        ),

                                        if (_croppedFileCitizenshipFrontFamily != null || _pickedFileCitizenshipFrontFamily != null)
                                          Column(
                                            children: const <Widget>[
                                              Text(
                                                'Citizenship Front',
                                                textAlign: TextAlign.center, style: TextStyle(
                                                  color: Colors.black54, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // TODO [Citizenship Back]
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: DottedBorder(
                              color: Colors.grey[400]!,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                child: Card(
                                  elevation: 0,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _pickedFileCitizenshipBackFamily = null;
                                                _croppedFileCitizenshipBackFamily = null;
                                              });

                                              // Capture a photo
                                              try {
                                                final XFile? pickedFile = await _picker.pickImage(
                                                  source: ImageSource.camera,
                                                  maxWidth: 1200.0,
                                                  maxHeight: 900.0,
                                                  imageQuality: 100,
                                                );
                                                setState(() {
                                                  _setCitizenshipBackFamily(pickedFile);
                                                });

                                              } catch (e) {
                                                setState(() {
                                                  _pickSingleImageError = e;
                                                });
                                              }
                                            },
                                            child: _citizenshipBackFamily(),
                                          ),
                                        ),

                                        if (_croppedFileCitizenshipBackFamily != null || _pickedFileCitizenshipBackFamily != null)
                                          Column(
                                            children: const <Widget>[
                                              Text(
                                                'Citizenship Back',
                                                textAlign: TextAlign.center, style: TextStyle(
                                                  color: Colors.black54, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (initIndentityType == 'राहदानी')
                      Column(
                        children: <Widget>[
                          // TODO [Passport]
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: DottedBorder(
                              color: Colors.grey[400]!,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(7)),
                                child: Card(
                                  elevation: 0,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  _pickedFileCitizenshipFrontFamily = null;
                                                  _croppedFileCitizenshipFrontFamily = null;
                                                });

                                                // Capture a photo
                                                try {
                                                  final XFile? pickedFile = await _picker.pickImage(
                                                    source: ImageSource.camera,
                                                    maxWidth: 1200.0,
                                                    maxHeight: 900.0,
                                                    imageQuality: 100,
                                                  );
                                                  setState(() {
                                                    _setCitizenshipFrontFamily(pickedFile);
                                                  });

                                                } catch (e) {
                                                  setState(() {
                                                    _pickSingleImageError = e;
                                                  });
                                                }
                                              },
                                              child: _passportFrontFamily()
                                          ),
                                        ),

                                        if (_croppedFileCitizenshipFrontFamily != null || _pickedFileCitizenshipFrontFamily != null)
                                          Column(
                                            children: const <Widget>[
                                              Text(
                                                'Passport Image',
                                                textAlign: TextAlign.center, style: TextStyle(
                                                  color: Colors.black54, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (initIndentityType == 'प्यान')
                        Column(
                          children: <Widget>[
                            // TODO [Pan]
                            Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              child: DottedBorder(
                                color: Colors.grey[400]!,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                padding: const EdgeInsets.all(6),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                                  child: Card(
                                    elevation: 0,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    _pickedFileCitizenshipFrontFamily = null;
                                                    _croppedFileCitizenshipFrontFamily = null;
                                                  });

                                                  // Capture a photo
                                                  try {
                                                    final XFile? pickedFile = await _picker.pickImage(
                                                      source: ImageSource.camera,
                                                      maxWidth: 1200.0,
                                                      maxHeight: 900.0,
                                                      imageQuality: 100,
                                                    );
                                                    setState(() {
                                                      _setCitizenshipFrontFamily(pickedFile);
                                                    });

                                                  } catch (e) {
                                                    setState(() {
                                                      _pickSingleImageError = e;
                                                    });
                                                  }
                                                },
                                                child: _panFrontFamily()
                                            ),
                                          ),

                                          if (_croppedFileCitizenshipFrontFamily != null || _pickedFileCitizenshipFrontFamily != null)
                                            Column(
                                              children: const <Widget>[
                                                Text(
                                                  'PAN Image',
                                                  textAlign: TextAlign.center, style: TextStyle(
                                                    color: Colors.black54, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10.0),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: <Widget>[
                            // TODO [Birth Certificate]
                            Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              child: DottedBorder(
                                color: ColorManager.themeRedColor,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                padding: const EdgeInsets.all(6),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                                  child: Card(
                                    elevation: 0,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    _pickedFileCitizenshipFrontFamily = null;
                                                    _croppedFileCitizenshipFrontFamily = null;
                                                  });

                                                  // Capture a photo
                                                  try {
                                                    final XFile? pickedFile = await _picker.pickImage(
                                                      source: ImageSource.camera,
                                                      maxWidth: 1200.0,
                                                      maxHeight: 900.0,
                                                      imageQuality: 100,
                                                    );
                                                    setState(() {
                                                      _setCitizenshipFrontFamily(pickedFile);
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      _pickSingleImageError = e;
                                                    });
                                                  }
                                                },
                                                child: _birthCertificateFrontFamily()
                                            ),
                                          ),

                                          if (_croppedFileCitizenshipFrontFamily != null || _pickedFileCitizenshipFrontFamily != null)
                                            Column(
                                              children: const <Widget>[
                                                Text(
                                                  'Birth Certificate Image',
                                                  textAlign: TextAlign.center, style: TextStyle(
                                                    color: Colors.black54, fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10.0),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                      ),
                      child: Text('Set Password (पासवर्ड सेट गर्नुहोस्)', style: TextStyle(fontSize: 15.0, color: Colors.black54,
                          fontWeight: FontWeight.bold), textAlign:
                      TextAlign.left),
                    ),

                    Container(
                        height: 15.0,
                        margin: const EdgeInsets.only(top: 3.0, bottom: 15.0),
                        width: double.infinity,
                        child: Image.asset("assets/images/main_layer.png", fit: BoxFit.cover)
                    ),

                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _password,
                      obscureText: true,
                      style: TextStyle(color: Colors.black54),
                      decoration: customTextFormField("Password (पासवर्ड) *"),
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 10.0),

                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _confirmPassword,
                      obscureText: true,
                      style: TextStyle(color: Colors.black54),
                      decoration: customTextFormField("Confirm Password (पासवर्ड सुनिश्चित गर्नुहोस) *"),
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: ElevatedButton(
                          child: isLoading ? const SizedBox(height: 24.0, width: 24.0,
                          child: CircularProgressIndicator(color: Colors.white)) : Text(
                              "Register".toUpperCase(),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(ColorManager.themeBlueColor),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: ColorManager.themeBlueColor)
                                  )
                              )
                          ),
                          onPressed: () {
                            if (_password.text.length > 7) {
                              if (_password.text.toString() == _confirmPassword.text.toString()) {
                                setState((){
                                  isLoading = true;
                                });
                                uploadDataOnServer();
                              } else {
                                errorLongToast("Password and confirm password must be same (पासवर्ड र कन्फर्म पासवर्ड एउटै हुनुपर्छ)");
                              }
                            } else {
                              errorLongToast("Password must be greater than 7 digits (पासवर्ड ७ अंक भन्दा ठुलो हुनु पर्छ)");
                            }
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getDropdownList() {
    List tokenDis = [];
    for (int i = 0; i < CountryData.countryJSON.length; i++) {
      if (CountryData.countryJSON[i]['pro_en'].toString() == initPradesh) {
        setState(() {
          tokenDis.add(CountryData.countryJSON[i]);
        });
      }
    }

    var decoded, mundecoded;
    List<String> dist = [];
    List<String> mun = [];
    for (int i = 0; i < tokenDis.length; i++) {
      decoded = tokenDis[i]['dis_en'];
      dist.add(decoded);
    }

    setState(() {
      dropdownDistrict = dist.toSet().toList();
      dropdownDistrict!.sort();
    });


    for (int i = 0; i < CountryData.countryJSON.length; i++) {
      if (initDistrict.toString() == CountryData.countryJSON[i]['dis_en'].toString()) {
        mundecoded = CountryData.countryJSON[i]['mun_en'];
        mun.add(mundecoded);
      }
    }

    setState(() {
      dropdownMun = mun.toSet().toList();
      dropdownMun!.sort();
      initMun = dropdownMun![0].toString();
    });

  }

  void getDistrictJSON(String initPradesh) {

    List tokenDis = [];
    for (int i = 0; i < CountryData.countryJSON.length; i++) {
      if (CountryData.countryJSON[i]['pro_en'].toString() == initPradesh) {
        setState(() {
          tokenDis.add(CountryData.countryJSON[i]);
        });
      }
    }

    var decoded, mundecoded;
    List<String> dist = [];
    List<String> mun = [];
    for (int i = 0; i < tokenDis.length; i++) {
      decoded = tokenDis[i]['dis_en'];
      dist.add(decoded);
    }

    setState(() {
      dropdownDistrict = dist.toSet().toList();
      dropdownDistrict!.sort();
      initDistrict = dropdownDistrict![0].toString();
    });


    for (int i = 0; i < CountryData.countryJSON.length; i++) {
      if (initDistrict.toString() == CountryData.countryJSON[i]['dis_en'].toString()) {
        mundecoded = CountryData.countryJSON[i]['mun_en'];
        mun.add(mundecoded);
      }
    }

    setState(() {
      dropdownMun = mun.toSet().toList();
      dropdownMun!.sort();
      initMun = dropdownMun![0].toString();
    });
  }

  void getMuncipality(String district) {

    var mundecoded;
    List<String> mun = [];


    for (int i = 0; i < CountryData.countryJSON.length; i++) {
      if (district.toString() == CountryData.countryJSON[i]['dis_en'].toString()) {
        mundecoded = CountryData.countryJSON[i]['mun_en'];
        mun.add(mundecoded);

        print('Munciplaity: ' + mun.toString());
      }
    }

    setState(() {
      dropdownMun = mun.toSet().toList();
      dropdownMun!.sort();
      initMun = dropdownMun![0].toString();
    });
  }

  /// family member / identity type image
  /// identity type image
  Widget _image() {
    if (_pickedFile != null) {
      return Stack(
        children: <Widget>[
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.themeRedColor,
                  borderRadius: BorderRadius.circular(90.0),
                  border: Border.all(color: ColorManager.themeRedColor, width: 1.0)
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.edit, color: Colors.white, size: 18.0),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            height: 100.0,
            width: 100.0,
            child: Container(
              width: 110.0,
              height: 110.0,
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.themeRedColor, width: 2.0),
                  borderRadius: BorderRadius.circular(90.0)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: Container(
                  height: 110.0,
                  width: 110.0,
                  child: kIsWeb ? Image.network(_pickedFile!.path, fit: BoxFit.cover) : Image.file(File(_pickedFile!.path), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      );
      // return Container(
      //   margin: const EdgeInsets.only(right: 15.0),
      //   height: 100.0,
      //   width: 100.0,
      //   child: Container(
      //     width: 110.0,
      //     height: 110.0,
      //     padding: const EdgeInsets.all(1.0),
      //     decoration: BoxDecoration(
      //         border: Border.all(color: ColorManager.themeRedColor, width: 2.0),
      //         borderRadius: BorderRadius.circular(90.0)
      //     ),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(90.0),
      //       child: Container(
      //         height: 110.0,
      //         width: 110.0,
      //         child: kIsWeb ? Image.network(_pickedFile!.path, fit: BoxFit.cover) : Image.file(File(_pickedFile!.path), fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.themeRedColor,
                  borderRadius: BorderRadius.circular(90.0),
                  border: Border.all(color: ColorManager.themeRedColor, width: 1.0)
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.edit, color: Colors.white, size: 18.0),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            height: 90.0,
            width: 90.0,
            child: Container(
              width: 80.0,
              height: 80.0,
              padding: const EdgeInsets.all(0.0),
              // decoration: BoxDecoration(
              //     border: Border.all(color: ColorManager.themeRedColor, width: 3.0),
              //     borderRadius: BorderRadius.circular(90.0)
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  child: Image.asset("assets/images/user1.png", fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _citizenshipFrontFamily() {
    if (_croppedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_croppedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_croppedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else if (_pickedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_pickedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_pickedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: const Icon(Icons.camera_alt_outlined, size: 34.0),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Click to capture front side of a citizenship',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }

  Widget _citizenshipBackFamily() {
    if (_croppedFileCitizenshipBackFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_croppedFileCitizenshipBackFamily!.path, fit: BoxFit.cover) : Image.file(File(_croppedFileCitizenshipBackFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else if (_pickedFileCitizenshipBackFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_pickedFileCitizenshipBackFamily!.path, fit: BoxFit.cover) : Image.file(File(_pickedFileCitizenshipBackFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: const Icon(Icons.camera_alt_outlined, size: 34.0),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Click to capture back side of a citizenship',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }

  Widget _passportFrontFamily() {
    if (_croppedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_croppedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_croppedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else if (_pickedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_pickedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_pickedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: const Icon(Icons.camera_alt_outlined, size: 34.0),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Click to capture a passport image',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }

  Widget _panFrontFamily() {
    if (_croppedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_croppedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_croppedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else if (_pickedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            border: Border.all(color: ColorManager.primary, width: 2.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_pickedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_pickedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: const Icon(Icons.camera_alt_outlined, size: 34.0),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Click to capture a PAN image',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }

  Widget _birthCertificateFrontFamily() {
    if (_pickedFileCitizenshipFrontFamily != null) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 0.0),
            borderRadius: BorderRadius.circular(0.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: kIsWeb ? Image.network(_pickedFileCitizenshipFrontFamily!.path, fit: BoxFit.cover) : Image.file(File(_pickedFileCitizenshipFrontFamily!.path), fit: BoxFit.cover),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90.0),
            child: const Icon(Icons.camera_alt_outlined, size: 34.0),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Click to capture a birth certificate image',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }
  }

  // get district
  void getAllDistrict() async {
    var dio = Dio();

    var formData = FormData.fromMap({
      'provisionid': provinceid,
    });
    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/districtall',
        data: formData
    );

    if (response.statusCode == 200) {
      setState(() {
        districtList = [];
        districtList = response.data['district'];
      });
    } else {
      errorToast("Something went wrong");
    }
  }

  // get municipality
  void getAllMunicipality() async {
    var dio = Dio();

    var formData = FormData.fromMap({
      'districtid': districtid,
    });

    print({
      'districtid': districtid,
    }.toString());

    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/municipalityall',
        data: formData
    );

    if (response.statusCode == 200) {
      setState(() {
        municipalityList = [];
        municipalityList = response.data['municipality'];
      });
    } else {
      errorToast("Something went wrong");
    }
  }

  void uploadDataOnServer() async {
    var dio = Dio();

    print({
      'profile': await MultipartFile.fromFile(File(_pickedFile!.path).path, filename: File(_pickedFile!.path).path.split('/').last),
      'deviceid': deviceId.toString(),
      'name': _name.text.toString(),
      'mobilenumber': _mobile.text.toString(),
      'password': _password.text.toString(),
      'email': _email.text.toString(),
      'dob': _dob.text.toString(),
      'fatherName': _fatherName.text.toString(),
      'motherName': _motherName.text.toString(),
      'gender': selectGender.toString(),
      'profession': professionid.toString(),
      'education': educationid.toString(),
      'caste': castid.toString(),
      'maritalstatus': selectedMartialStatus.toString(),
      'provision': provinceid.toString(),
      'district': districtid.toString(),
      'municipality': municipalityid.toString(),
      'ward': _ward.text.toString(),
      'streetAddress': _streetAddress.text.toString(),
      'bloodGroup': selectBloodGroup.toString(),
      'identityType': initIndentityType.toString(),
      'citizenshipFront': initIndentityType == 'नागरिकता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'citizenshipBack': initIndentityType == 'नागरिकता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipBackFamily!.path).path, filename: File(_pickedFileCitizenshipBackFamily!.path).path.split('/').last) : "",
      'passport': initIndentityType == 'राहदानी' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'pan': initIndentityType == 'प्यान' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'birthCertificate': initIndentityType == 'जन्म दर्ता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : ""
    }.toString());

    var formData = FormData.fromMap({
      'profile': await MultipartFile.fromFile(File(_pickedFile!.path).path, filename: File(_pickedFile!.path).path.split('/').last),
      'deviceid': deviceId.toString(),
      'name': _name.text.toString(),
      'mobilenumber': _mobile.text.toString(),
      'password': _password.text.toString(),
      'email': _email.text.toString(),
      'dob': _dob.text.toString(),
      'fatherName': _fatherName.text.toString(),
      'motherName': _motherName.text.toString(),
      'gender': selectGender.toString(),
      'profession': professionid.toString(),
      'education': educationid.toString(),
      'caste': castid.toString(),
      'maritalstatus': selectedMartialStatus.toString(),
      'provision': provinceid.toString(),
      'district': districtid.toString(),
      'municipality': municipalityid.toString(),
      'ward': _ward.text.toString(),
      'streetAddress': _streetAddress.text.toString(),
      'bloodGroup': selectBloodGroup.toString(),
      'identityType': initIndentityType.toString(),
      'citizenshipFront': initIndentityType == 'नागरिकता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'citizenshipBack': initIndentityType == 'नागरिकता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipBackFamily!.path).path, filename: File(_pickedFileCitizenshipBackFamily!.path).path.split('/').last) : "",
      'passport': initIndentityType == 'राहदानी' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'pan': initIndentityType == 'प्यान' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : "",
      'birthCertificate': initIndentityType == 'जन्म दर्ता' ? await MultipartFile.fromFile(File(_pickedFileCitizenshipFrontFamily!.path).path, filename: File(_pickedFileCitizenshipFrontFamily!.path).path.split('/').last) : ""
    });
    var response = await dio.post('https://cpnapp.itsolutionsnepal.com/api/register',
        data: formData
    );

    if (response.statusCode == 200) {
      var responseData = await response.data;
      var myJSON = json.decode(responseData);
      if (myJSON['type'] != 'error') {
        successToast(myJSON['message'].toString());
        setState((){isLoading = false;});
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        errorToast(myJSON['message'].toString());
        setState((){isLoading = false;});
      }
    } else {
      errorToast("Something went wrong");
      setState((){isLoading = false;});
    }
  }

  void getDeviceId() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    print('Device id: ' + osUserID.toString());

    setState((){
      deviceId = osUserID.toString();
    });
  }
}
