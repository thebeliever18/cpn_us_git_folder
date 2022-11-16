import 'package:cpn_us/landing/bloc/landing_bloc.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/strings_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItems extends StatefulWidget {
  final String menuTitle;
  final IconData menuIcon;
  final int index;
  final void Function()? onTap;
  MenuItems(
      {Key? key,
      required this.menuTitle,
      required this.menuIcon,
      required this.index,
      this.onTap})
      : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool isActivate=false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        if(state is LandingIndexChanged){
          if(state.index==widget.index){
            isActivate=state.activate;
          }else{
            isActivate=false;
          }
          
        }
      
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p40),
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                height: AppSize.s50,
                decoration: BoxDecoration(
                    color: isActivate ? ColorManager.lightBlue : null,
                    border: Border.all(
                        color: Colors.transparent, style: BorderStyle.solid),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(20.0))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    isActivate
                        ? Icon(
                            Icons.circle,
                            size: AppSize.s8,
                            color: ColorManager.skyBlue,
                          )
                        : const SizedBox(width: AppSize.s8),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Transform.rotate(
                      angle: widget.menuTitle == AppStrings.notices ? 45.0 : 0.0,
                      child: Icon(widget.menuIcon,
                          size: AppSize.s32,
                          color: isActivate
                              ? ColorManager.skyBlue
                              : ColorManager.blackishBlue),
                    ),
                    const SizedBox(
                      width: AppSize.s22,
                    ),
                    Text(widget.menuTitle,
                        style: isActivate
                            ? Theme.of(context).textTheme.headline4
                            : Theme.of(context).textTheme.headline3)
                  ],
                ),
              ),
            ),
          ),
          //SizedBox(height: AppSize.s1_5,)
        ],
      );
      }
    );
  }
}
