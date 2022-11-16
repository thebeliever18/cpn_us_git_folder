import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/font_manager.dart';
import 'package:cpn_us/resources/styles_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(

      //main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      //ripple color
      splashColor: ColorManager.primaryOpacity70,

      //for example will be used incase of disabled button
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

      //card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      //button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      //text theme
      textTheme: TextTheme(
        headline1: getSemiBoldTextStyle(
            fontSize: FontSize.s16, color: ColorManager.darkGrey),
        headline2: getBoldTextStyle(
            fontSize: FontSize.s20, color: ColorManager.drakBlue),
        headline3: getRegularStyle(
            fontSize: FontSize.s16, color: ColorManager.blackishBlue),
        headline4: getSemiBoldTextStyle(
            fontSize: FontSize.s16, color: ColorManager.skyBlue),
        headline6: getBoldTextStyle(
            fontSize: FontSize.s16, color: ColorManager.drakBlue),
        headline5: getSemiBoldTextStyle(
            fontSize: FontSize.s35, color: ColorManager.white),
        headlineLarge: getSemiBoldTextStyle(
            fontSize: FontSize.s20, color: ColorManager.drakBlue),
        subtitle1: getSemiBoldTextStyle(
            fontSize: FontSize.s14, color: ColorManager.drakBlue),
        subtitle2: getMediumTextStyle(
            color: ColorManager.primary, fontSize: FontSize.s14),
        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText2: getRegularStyle(color: ColorManager.blackishBlue),
        bodyText1: getRegularStyle(color: ColorManager.grey,fontSize: FontSize.s14),
        labelMedium: getMediumTextStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s15),
        
      ),
      iconTheme: IconThemeData(color: ColorManager.drakBlue),
      primaryIconTheme: IconThemeData(color: ColorManager.drakBlue),
      
      //input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(AppPadding.p8),

          //hint style
          hintStyle: getRegularStyle(color: ColorManager.grey1),

          //label style
          labelStyle: getMediumTextStyle(color: ColorManager.darkGrey),

          //error style
          errorStyle: getRegularStyle(color: ColorManager.error),

          //enabled border
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.drakBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //focused border
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.drakBlue, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          suffixIconColor: ColorManager.drakBlue,
          
          //error border
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.error,
                width: AppSize.s1_5,
              ),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8))),

          //focused error border
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s8)))));

                  
}
