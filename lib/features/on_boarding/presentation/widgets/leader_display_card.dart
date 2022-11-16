
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cpn_us/core/helper/navigation_helper/navigation_helper.dart';
import 'package:cpn_us/dependency_injection.dart';
import 'package:cpn_us/resources/color_manager.dart';
import 'package:cpn_us/resources/routes_manager.dart';
import 'package:cpn_us/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LeaderDisplayCard extends StatelessWidget {
  final String name;
  final String image;
  final String position;
  final bool hasVideo;
  
  const LeaderDisplayCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.position,
      this.hasVideo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s200,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(AppSize.s4),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 1.0,
              color: ColorManager.grey3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: AppSize.s45,
              backgroundImage: CachedNetworkImageProvider(image)),
          const SizedBox(
            height: AppSize.s4,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
            maxLines: hasVideo?2:null,
            overflow: TextOverflow.ellipsis
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          InkWell(
            onTap: hasVideo? (){
                  final NavigationHelper navigationHelper = sl<NavigationHelper>();
                  navigationHelper.navigateTo(Routes.cpnUsWebView,arguments: [position,name]);
            }:null,
            child: Container(
                width: AppSize.s100,
                height: AppSize.s30,
                decoration: BoxDecoration(
                    color: ColorManager.skyBlue2,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(AppSize.s4),),
                child: Center(
                    child: Text(
                  hasVideo?'Open Link':position,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorManager.white),
                ),),),
          ),
        ],
      ),
    );
  }
}
