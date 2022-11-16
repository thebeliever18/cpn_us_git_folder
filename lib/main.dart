import 'package:flutter/material.dart';
import 'package:cpn_us/dependency_injection.dart' as di;
import 'package:flutter/services.dart';
import 'my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]);
  await di.init();
  runApp(MyApp());
}