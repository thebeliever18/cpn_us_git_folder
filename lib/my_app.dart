import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/mult_bloc_providers.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
   const MyApp._instance(); //private named constructor
  
  static const MyApp instance = MyApp._instance(); //single instance --singleton
  
  factory MyApp() => instance; //factory for the class instance
  
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MultiBlocProviders.blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        navigatorKey: sl<NavigationHelper>().navigatorKey,
        theme: getApplicationTheme(),
      ),
    );
  }
}