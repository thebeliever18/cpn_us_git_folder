import 'package:flutter/cupertino.dart';

class NavigationHelper{ 
  final GlobalKey<NavigatorState> navigatorKey;
  NavigationHelper({required this.navigatorKey});

  Future<dynamic> navigateTo(String routeName,{dynamic arguments}){
    return navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
  }

  //TODO:[SPANDAN] implementation of popping 2 or 3 page back is left
  void pop({int count=0}){
    if(count>0){
      return navigatorKey.currentState!.popUntil((route) => count-- ==0);
    }
    return navigatorKey.currentState!.pop();
  }

    

  //pushReplacementNamed
  Future<dynamic> pushReplacementNamed(String routeName,{dynamic arguments}) {
     return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }
  
  //TODO:[SPANDAN] implementation of popUntil with ModalRoute

  //pushNamedAndRemoveUntil
  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  //TODO:[SPANDAN] implementation of popUntilFirst i.e. popUntil => route.isFirst
  


  

  




}